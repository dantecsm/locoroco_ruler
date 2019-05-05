%% ��ȡһ��ͼ����ڽӾ��󣬱߱�ž���,ɢ��ͼ����ɢ��ͼ��
%% ����:һ��ͼ��f������ģscale
%% �������ͼ���ڽӾ���gm,�߱�ž���emap��ɢ��ͼ��elabel��ɢ��ͼ��plabel
%% ע�������ģ�ɲ��Ĭ��Ϊ10�������г���ʱ��һ���ϴ�����ɽ����
function [gm emap elabel plabel]=g2m(f,scale)
if nargin==1
    scale=10;
end
g=f;
g=im2bw(g);
g=~g;
h=bwmorph(g,'thin',inf);    %��ȡͼ������

model=zeros(size(g));
points=catch_point(f);  % ��catch_point�����������ͼ��ĺ��
if isempty(points)  %���û��㣬�ֹ�����ͼ��ĵ�
    imshow(f);
    points=ginput;
    points=round(points);
    close all;
end
for i=1:length(points(:))/2
model(points(i,2),points(i,1))=1;   %modelΪϸ��ͼ��
end
se= strel('disk',scale);   %���ð뾶Ϊ5��Բ�̽��е�����
fse=imdilate(model,se); %fseΪ�ֵ�ͼ��
plabel=fse;
elabel=h.*~fse;   %elabelΪȥ���ɢ��ͼ

[p pnum]=bwlabel(fse);
[e enum]=bwlabel(elabel);
% figure,imshow(p);
% figure,imshow(e);
point={};   %ά����Ԫ��Ԫ��
for i=1:pnum
    p2=p;
    p2(p2~=i)=0;
    point{i}=p2;
end
edge={};    %ά����Ԫ��Ԫ��
for i=1:enum
    e2=e;
    e2(e2~=i)=0;
    edge{i}=e2;
end

gm=zeros(pnum); %��ʼ���ڽӾ���
emap=[];    %��ʼ���߱�ž���
temp={};
for i=1:enum   %����ÿһ���������е���ڽ������ά���ڽӾ���
    link=[];
    [~,num1]=bwlabel(edge{i});
    for j=1:pnum
        temp{j}=edge{i}+point{j};
%         figure,imshow(temp{j});
        [~,num2]=bwlabel(temp{j});
        if num1==num2  %����ӵ�ǰ����ͨ��������䣬����ż���link����
            link=[link j];
        end
    end
if size(link,2)==1  %�����ΰ�j��ά��Ϊ��i����ͬ
        link(2)=link(1); 
        gm(link(2),link(1))=gm(link(2),link(1))+1;
        emap(link(1),link(2),gm(link(1),link(2)))=i;    %ά���߱�ž���
        emap(link(2),link(1),gm(link(1),link(2)))=i;
    else
        gm(link(1),link(2))=gm(link(1),link(2))+1;  %ά���ڽӾ���
        gm(link(2),link(1))=gm(link(2),link(1))+1;
        emap(link(1),link(2),gm(link(1),link(2)))=i;    %ά���߱�ž���
        emap(link(2),link(1),gm(link(1),link(2)))=i;
    end
end