%% 根据散边图与散点图用顺序数组组织成gif动态图
%% 输入：散边图像elabel,散点图像plabel,以及顺序数组seq
%% 输出：一张“一笔.gif”图像
%% 第四参数可不管，若输入，可控制动态图速度，供调试用
function seq2gif(elabel,plabel,seq,speed)
[l2,~]=bwlabel(elabel);   %为散边图标记连通域
[l4,~]=bwlabel(plabel);   %为散点图标记连通域
stepall=length(seq);
frame={};   %帧图元胞
for i=1:stepall
    if seq(i)<0     %负序列元素代表取点
        seq(i)=-seq(i);
        l=l4;
    else        %正序列元素代表取边
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
% imwrite(l3,picname);   %此两行按序生成多帧gif过程图像*.png
end
if nargin<4
    speed=0.2;
end

for i=1:stepall    %把多张gif过程图叠加为gif
    if i==1
        imwrite(~frame{i},'一笔.gif','gif','Loopcount',inf,'DelayTime',speed);
        else
        imwrite(~frame{i},'一笔.gif','gif','WriteMode','append','DelayTime',speed);
    end;
end