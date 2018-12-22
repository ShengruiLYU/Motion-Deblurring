close all; clear; clc;
Files = dir(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\add_blur\blurred_car','1.jpg'));
%Files = dir(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\blur3_car\blur','*.jpg'));
LengthFiles = length(Files);
for i = 1:LengthFiles
    name = Files(i).name;
    res = deblur(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\add_blur\',name));
    imwrite(res, strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\deblur_random\deblurred-',name));
    
    %res = deblur(strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\blur3_car\',name));
    %imwrite(res, strcat('C:\Users\Shengrui\Desktop\ELEC 4130 Projec\deblur3_car\',name));
end
