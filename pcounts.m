%% ���룺�ڽӾ���  �������ͨ��֧��  ע���ڶ�������Ϊ�����㲻��Ϊ��ͨ��֧��
%% ������ȥ��֮���õ㣬������ŵ���ȷ�жϷ�ʽ
function parts=pcounts(A,x)
D=diag(sum(A));
single=length(find(sum(A)==0));
L=D-A;  %���ԭͼ��������˹����
n=eig(L);
parts=length(find(n<1e-10));  %����������˹����0����ֵ����
if nargin==2
parts=parts-single;
end
end