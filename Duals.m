clc
clear all
format rat
%Sample Problem
%Min: 5x1+6x2
%s.t constraints 
% x1+x2>=2
% 4x1+x2>=4
% x1,x2>=0
%% PHASE1-INPUT PARAMETER
Info=[-1 -1 1 0;-4 -1 0 1];
Cost=[-5 -6 0 0 0];
b=[-2;-4];
variables={'x1','x2','s1','s2','Sol'};
A=[Info b];
%% PHASE 2-First Table
s=eye(size(A,1));
bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            bv=[bv i];
        end
    end
end
fprintf('Basic Variables are') 
disp(variables(bv))

zjcj=Cost(bv)*A-Cost;
table=[zjcj;A];
Table1=array2table(table);
Table1.Properties.VariableNames(1:size(table,2))=variables
%% Phase3- Dual Simplex Concept
RUN=true;
while RUN
    Sol=A(:,end);
    if any(Sol<0)
    fprintf('The current solution is not feasible \n')
    %% find the leaving variable
    [minval,pivot_row]=min(Sol);
    fprintf('Leaving variable is')
    disp(variables(bv(pivot_row)))
    %% find the entering variable
    X=A(pivot_row,1:end-1);
    Y=zjcj(:,1:end-1);
    for i=1:size(X,2)
        if(X(i)<0)
            
            ratio(i)=abs(Y(i)/X(i));
        else
            ratio(i)= inf;
        end
    end
    [minratio,pivot_col]=min(ratio);
    fprintf('Entering variable is')
    disp(variables(pivot_col))
    pivot_key=A(pivot_row,pivot_col) 
    bv(pivot_row)=pivot_col 
    fprintf('Basic Variables are') 
    disp(variables(bv))
    %% Update the table
    A(pivot_row,:)=A(pivot_row,:)./pivot_key;
     for j=1:size(A,1)
         if j~=pivot_row
            A(j,:)=A(j,:)-A(j,pivot_col).*A(pivot_row,:);
            zjcj=Cost(bv)*A-Cost;
         end
     end
  
else
    RUN=false;
    fprintf('Feasible Solution obtained')
    table=[zjcj;A];
    Table1=array2table(table);
    Table1.Properties.VariableNames(1:size(table,2))=variables
    fprintf('The final BFS is')
   
    final=zeros(1,size(A,2));
    final(bv)=A(:,end);
    Z=-sum(final.*Cost);
    final(end)=Z;
    Table_fin=array2table(final);
    Table_fin.Properties.VariableNames(1:size(final,2))=variables
    
    
  
    
end
end
