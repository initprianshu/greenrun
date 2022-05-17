clc;
clear all;
cost=[11,20,7,8;21,16,10,12;8,12,18,9];
A=[50;40;70];
B=[30;25;35;40];
if sum(A)==sum(B)
    frpintf("Balanced");
else
    fprintf("Unbalanced");
    if sum(A)>sum(B)
        cost(:,end+1)=zeros(1,size(A,1));
        B(end+1)=sum(A)-sum(B);
    else
        cost(end+1,:)=zeros(size(cost,1),1);
        A(end+1)=sum(B)-sum(A);
    end
    copy=cost;
    x=zeros(size(cost,1));
    for m=1:size(cost,1)
        for n=1:size(cost,2)
            val=min(cost(:));
            [rowInd,colInd]=find(val==cost);
            x11=min(A(rowInd),B(colInd));
            [y11 ind]=max(x11);
            i=rowInd(ind);
            j=colInd(ind);
            A(i)=A(i)-y11;
            B(j)=B(j)-y11;
            cost(i,j)=inf;
            x(i,j)=y11;
        end
    end
    disp(sum(sum(x.*copy)))
    
end
        
