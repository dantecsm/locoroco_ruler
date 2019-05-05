%% 输入：邻接矩阵  输出：连通分支数  注：第二输入意为孤立点不记为连通分支，
%% 按经验去边之后不用点，这才是桥的正确判断方式
function parts=pcounts(A,x)
D=diag(sum(A));
single=length(find(sum(A)==0));
L=D-A;  %求解原图的拉普拉斯矩阵
n=eig(L);
parts=length(find(n<1e-10));  %计数拉普拉斯矩阵0特征值个数
if nargin==2
parts=parts-single;
end
end