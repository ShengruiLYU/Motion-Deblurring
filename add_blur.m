close all; clear;
Files = dir(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\project_dataset\','*.jpg'));
TotalNumber= length(Files);
for i = 1:TotalNumber
    name = Files(i).name;
    len = randi([10,30]);
    theta = randi([0,90]);
    PSF = fspecial('motion',len,theta);
    image = imread(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\project_dataset\',name));
    blurred = imfilter(image,PSF,'conv','replicate');
    imshow(blurred);
    blur_file_name=strcat('blurred_car',num2str(i),'.jpg');
    imwrite(blurred, blur_file_name);
end