close all;

fileRoot='./result_a/';  
  
list=dir(fullfile(fileRoot));  

fileNum = size(list,1)-2;  

yy = [];
uu = [];

for k=3:fileNum
    fileName = list(k).name;
    filePath = strcat(fileRoot, fileName);
    load(filePath)
    yy = [yy; y.data(1:200)'];
    uu = [uu; u.data(1:200)'];
end  

image(yy .* 50)

figure
image(uu .* 20)