%% ��ȡһ��ͼ��ĺ������
%% ���룺RGBͼƬ����f
%% ��������к��(��ɫ����)��������
function point=catch_point(f)
h=zeros(size(f,1),size(f,2));
h(f(:,:,1)>f(:,:,2)+f(:,:,3)+100)=1;    %�������к��
[l num]=bwlabel(h);     %ͳ�����к�����ģ�����point����
stats=regionprops(l);
point=[];
for i=1:num
point=[point;round(stats(i).Centroid)];
end