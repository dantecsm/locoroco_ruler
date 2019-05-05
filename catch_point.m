%% 获取一张图像的红点坐标
%% 输入：RGB图片矩阵f
%% 输出：所有红点(红色区域)中心坐标
function point=catch_point(f)
h=zeros(size(f,1),size(f,2));
h(f(:,:,1)>f(:,:,2)+f(:,:,3)+100)=1;    %搜索所有红点
[l num]=bwlabel(h);     %统计所有红点中心，计入point数组
stats=regionprops(l);
point=[];
for i=1:num
point=[point;round(stats(i).Centroid)];
end