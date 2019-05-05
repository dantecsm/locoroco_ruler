%% 获取一张图像的邻接矩阵，边标号矩阵,散边图像与散点图像
%% 输入:一张图像f与点检测规模scale
%% 输出：该图的邻接矩阵gm,边标号矩阵emap，散边图像elabel与散点图像plabel
%% 注：点检测规模可不填，默认为10，当运行出错时赋一个较大的数可解决。
function [gm emap elabel plabel]=g2m(f,scale)
if nargin==1
    scale=10;
end
g=f;
g=im2bw(g);
g=~g;
h=bwmorph(g,'thin',inf);    %提取图像脉络

model=zeros(size(g));
points=catch_point(f);  % 用catch_point函数检测输入图像的红点
if isempty(points)  %如果没红点，手工输入图像的点
    imshow(f);
    points=ginput;
    points=round(points);
    close all;
end
for i=1:length(points(:))/2
model(points(i,2),points(i,1))=1;   %model为细点图像
end
se= strel('disk',scale);   %利用半径为5的圆盘进行点膨胀
fse=imdilate(model,se); %fse为粗点图像
plabel=fse;
elabel=h.*~fse;   %elabel为去点的散边图

[p pnum]=bwlabel(fse);
[e enum]=bwlabel(elabel);
% figure,imshow(p);
% figure,imshow(e);
point={};   %维护点元素元胞
for i=1:pnum
    p2=p;
    p2(p2~=i)=0;
    point{i}=p2;
end
edge={};    %维护边元素元胞
for i=1:enum
    e2=e;
    e2(e2~=i)=0;
    edge{i}=e2;
end

gm=zeros(pnum); %初始化邻接矩阵
emap=[];    %初始化边标号矩阵
temp={};
for i=1:enum   %分析每一条边与所有点的邻接情况，维护邻接矩阵
    link=[];
    [~,num1]=bwlabel(edge{i});
    for j=1:pnum
        temp{j}=edge{i}+point{j};
%         figure,imshow(temp{j});
        [~,num2]=bwlabel(temp{j});
        if num1==num2  %如果加点前后连通域个数不变，将点号计入link数组
            link=[link j];
        end
    end
if size(link,2)==1  %环情形把j点维护为与i点相同
        link(2)=link(1); 
        gm(link(2),link(1))=gm(link(2),link(1))+1;
        emap(link(1),link(2),gm(link(1),link(2)))=i;    %维护边标号矩阵
        emap(link(2),link(1),gm(link(1),link(2)))=i;
    else
        gm(link(1),link(2))=gm(link(1),link(2))+1;  %维护邻接矩阵
        gm(link(2),link(1))=gm(link(2),link(1))+1;
        emap(link(1),link(2),gm(link(1),link(2)))=i;    %维护边标号矩阵
        emap(link(2),link(1),gm(link(1),link(2)))=i;
    end
end