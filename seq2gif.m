%% ����ɢ��ͼ��ɢ��ͼ��˳��������֯��gif��̬ͼ
%% ���룺ɢ��ͼ��elabel,ɢ��ͼ��plabel,�Լ�˳������seq
%% �����һ�š�һ��.gif��ͼ��
%% ���Ĳ����ɲ��ܣ������룬�ɿ��ƶ�̬ͼ�ٶȣ���������
function seq2gif(elabel,plabel,seq,speed)
[l2,~]=bwlabel(elabel);   %Ϊɢ��ͼ�����ͨ��
[l4,~]=bwlabel(plabel);   %Ϊɢ��ͼ�����ͨ��
stepall=length(seq);
frame={};   %֡ͼԪ��
for i=1:stepall
    if seq(i)<0     %������Ԫ�ش���ȡ��
        seq(i)=-seq(i);
        l=l4;
    else        %������Ԫ�ش���ȡ��
        l=l2;
    end
l(l~=seq(i))=0;
if i==1
    l3=l;
else
    l3=l3+l;
end
frame{i}=l3;
% picname=[num2str(i) '.png'];
% imwrite(l3,picname);   %�����а������ɶ�֡gif����ͼ��*.png
end
if nargin<4
    speed=0.2;
end

for i=1:stepall    %�Ѷ���gif����ͼ����Ϊgif
    if i==1
        imwrite(~frame{i},'һ��.gif','gif','Loopcount',inf,'DelayTime',speed);
        else
        imwrite(~frame{i},'һ��.gif','gif','WriteMode','append','DelayTime',speed);
    end;
end