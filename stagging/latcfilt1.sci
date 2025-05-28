function [f,g,zo]=latcfilt1(k,v,x,zi)
// Apply a lattice filter to a signal (vector only).
//
// Syntax
//   [f, g, zo] = latcfilt1(k, v, x, zi)
//
// Parameters
// k: Reflection coefficients (vector).
// v: Ladder coefficients (vector).
// x: Input signal (vector).
// zi: Initial conditions (vector).
//
// Description
// The `latcfilt1` function applies a lattice filter to the input signal `x` using the reflection coefficients `k` 
// and ladder coefficients `v`. This function is specifically designed for vector inputs. The initial conditions 
// `zi` are used to initialize the filter state.
//
// Examples
// k = [0.5, -0.3, 0.2];
// v = [0.1, 0.2, 0.3, 1];
// x = [1, 2, 3, 4];
// zi = [0, 0, 0];
// [f, g, zo] = latcfilt1(k, v, x, zi)
//
// Authors
// Parthasarathi Panda  ( parthasarathipanda314@gmail.com )

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
