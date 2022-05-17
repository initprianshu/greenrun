clc
clear all
format short
f=@(x) (x<0.5).*((1-x)/2)+(x>=0.5).*((x)^2);
L=-1;
R=1;
n=6;
mat=[];
fibon=ones(1,n);
for i=3:n+1
    fibon(i)=fibon(i-1)+fibon(i-2);
end

for k=1:n
    ratio=fibon(n+1-k)./fibon(n+2-k);
    x2=L+ratio.*(R-L);
    x1=L+R-x2;
    mat(k,:)=[L R x1 x2 f(x1) f(x2)]
    if(f(x1)<f(x2))
        R=x2;
    elseif( f(x1)>f(x2))
            L=x1;
    else
        if min(abs(L),abs(x1))==abs(L)
            R=x2;
        else
            L=x1;
        end
    end
end
xopt=(L+R)/2
f(xopt)
    
    
    