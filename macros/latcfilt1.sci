//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
//the function is for application on vectors only
function [f,g,zo]=latcfilt1(k,v,x,zi)
    N=length(k);
    gv=zi;
    //gv[n+1]=Agv[n]+Bfv[n]
    //fv[n]=-Cgv[n]+Dx[n]
    //computing A,B,C and D as required by the system
    C=[];
    for i=[1:N]
        C=[C;[zeros(1,N-i),(k(i:N))']]
    end
    A=[zeros(1,N);[eye(N-1,N-1),zeros(N-1,1)]];
    B=[1,zeros(1,N-1);diag(k(1:(N-1))),zeros(N-1,1)];
    D=ones(N,1);
    l=length(x);
    g=[];
    f=[];
    //iterating through the input entry
    for i=[1:l]
        fv=D*x(i)-C*gv;
        gv=A*gv+B*fv;
        g=[g;gv(N)+k(N)*fv(N)];
        f=[f;v(N+1)*g(i)+(v(1:N))'*gv];
    end
    zo=gv;
endfunction
