%% ���룺�ڽӾ�������ĳ�ߵ��������  ���������˱߲����ڣ�����2
%% ����˱����ţ�����1������˱߷��ţ�����0
function judge=is_bridge(a,i,j)
if a(i,j)==0 
judge=2;
else
oparts=pcounts(a);
a2=a;
a2(i,j)=a2(i,j)-1;
a2(j,i)=a2(j,i)-1;
aparts=pcounts(a2);
if aparts==oparts
judge=0;
else
judge=1;
end
end