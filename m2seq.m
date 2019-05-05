%% 根据一个邻接矩阵及边标号矩阵用算法算出一笔画边序列  注：目前尚不能求半欧拉图
%% 输入：一个邻接矩阵gm及对应的边标号矩阵emap
%% 输出：边点序列
function seq=m2seq(gm,emap)
i=1;    %因是欧拉回路，故任选第一点为起点
pnum=length(gm);    %获取点数
vis=zeros(1,pnum);  %点访问数组
seq=[];
while sum(gm(:))~=0    %重复以下步骤直到邻接矩阵为空（无边可取）
    if vis(i)==0;      %如当前访问点未写入序列，将该点写入序列并标记“已写入”
        seq=[seq -i];
        vis(i)=1;
    end
    pana=[];    %pana数组存放对一个点所连各边的性质分析
    for j=1:pnum
    pana(j)=1-is_bridge(gm,i,j);
    end
    x=find(pana==1);    %x代表非桥边的集合
    y=find(pana==0);    %y代表桥的集合
    if ~isempty(x)  %优先走非桥的边
        x=x(1);
        seq=[seq emap(i,x,gm(i,x))];
        gm(i,x)=gm(i,x)-1;
        gm(x,i)=gm(x,i)-1;
        i=x;
    elseif ~isempty(y)  %无非桥的边时只能走桥
        y=y(1);
        seq=[seq emap(i,y,gm(i,y))];
        gm(i,y)=gm(i,y)-1;
        gm(y,i)=gm(y,i)-1;
        i=y;
    else    %无路可走，说明不能一笔画，邻接矩阵不可能为空，强制跳出
        break;
    end
end