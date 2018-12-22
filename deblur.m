function res = deblur(name)

blurred = imread(name);
blurred_image_double = double(rgb2gray(blurred));

%% Blurring Angle
PQ = paddedsize(size(blurred_image_double));
Frequency_image = abs(fft2(blurred_image_double, PQ(1), PQ(2)));
figure(1); imshow(uint8(Frequency_image));

Frequency_image = histeq(uint8(Frequency_image));
figure(2); imshow(uint8(Frequency_image));
Frequency_image=amedfilt2_calc(Frequency_image);
figure(3); imshow(uint8(Frequency_image));
Binary_frequncy = 1-(Frequency_image>127);
figure(4); imshow(uint8(Binary_frequncy),[]);
Binary_frequncy = 255 * bwareaopen(Binary_frequncy, 50);
figure(5); imshow(uint8(Binary_frequncy));
[rows, columns, numberOfColorChannels] = size(Binary_frequncy);
Binary_frequncy = Binary_frequncy(:,1:columns/2);
figure(6);imshow(uint8(Binary_frequncy),[]);

Binary_frequncy=amedfilt2_calc(Binary_frequncy);
Edge_image=edge(Binary_frequncy,'canny');
figure(15);
imshow(Edge_image);
theta_range=0:90;
[R,~]=radon(Edge_image,theta_range);
[~,theta1]=find(R>=max(max(R)));

theta = theta1


%% Blurring Length
[xRange, yRange] = size(blurred_image_double);
rotated_image = imrotate(blurred_image_double,-theta,'bilinear','loose');
figure(7);imshow(uint8(rotated_image),[])
[xRange2, yRange2] = size(rotated_image);
if(yRange>xRange)
   x1 = floor((xRange2-xRange*cos(theta/180*pi))/2)
   y1 = floor((yRange2-xRange*sin(theta/180*pi))/2)
else
   x1 = floor((xRange2-yRange*sin(theta/180*pi))/2)
   y1 = floor((yRange2-yRange*cos(theta/180*pi))/2)
end
rotated_image = rotated_image(x1:end-x1,y1:end-y1);
figure(8);imshow(uint8(rotated_image),[])
Enhanced_image = conv2(rotated_image,[0.5,-0.5]);
figure(9);imshow(uint8(Enhanced_image),[])
[xRange2, yRange2] = size(Enhanced_image);
Enhanced_image(:,1) = 0;
Enhanced_image(:,yRange2) = 0;
for i = 1:xRange2
    s(i,:) = xcorr(Enhanced_image(i,:));
    [~,temp] = min(s(i,:));
    distance(i) = abs(yRange2-temp);
end
Sorted_distance = tabulate(distance);
[~,I] = max(Sorted_distance(1:end-2,2));
length = Sorted_distance(I,1)

%% Wiener Filter
PSF = fspecial('motion',length,theta);
R = deconvwnr(double(blurred(:,:,1)),PSF,0.001);
G = deconvwnr(double(blurred(:,:,2)),PSF,0.001);
B = deconvwnr(double(blurred(:,:,3)),PSF,0.001);
res = uint8(cat(3, R, G, B));
figure; imshow(res);
