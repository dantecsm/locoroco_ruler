%% ����һ���ڽӾ��󼰱߱�ž������㷨���һ�ʻ�������  ע��Ŀǰ�в������ŷ��ͼ
%% ���룺һ���ڽӾ���gm����Ӧ�ı߱�ž���emap
%% ������ߵ�����
function seq=m2seq(gm,emap)
i=1;    %����ŷ����·������ѡ��һ��Ϊ���
pnum=length(gm);    %��ȡ����
vis=zeros(1,pnum);  %���������
seq=[];
while sum(gm(:))~=0    %�ظ����²���ֱ���ڽӾ���Ϊ�գ��ޱ߿�ȡ��
    if vis(i)==0;      %�統ǰ���ʵ�δд�����У����õ�д�����в���ǡ���д�롱
        seq=[seq -i];
        vis(i)=1;
    end
    pana=[];    %pana�����Ŷ�һ�����������ߵ����ʷ���
    for j=1:pnum
    pana(j)=1-is_bridge(gm,i,j);
    end
    x=find(pana==1);    %x������űߵļ���
    y=find(pana==0);    %y�����ŵļ���
    if ~isempty(x)  %�����߷��ŵı�
        x=x(1);
        seq=[seq emap(i,x,gm(i,x))];
        gm(i,x)=gm(i,x)-1;
        gm(x,i)=gm(x,i)-1;
        i=x;
    elseif ~isempty(y)  %�޷��ŵı�ʱֻ������
        y=y(1);
        seq=[seq emap(i,y,gm(i,y))];
        gm(i,y)=gm(i,y)-1;
        gm(y,i)=gm(y,i)-1;
        i=y;
    else    %��·���ߣ�˵������һ�ʻ����ڽӾ��󲻿���Ϊ�գ�ǿ������
        break;
    end
end