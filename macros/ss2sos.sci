//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function [sos,g]=ss2sos(A,B,C,D)
//not taking if, order and scale as input since they do not seem useful
    if (type(A)~=1 | type(B)~=1 | type(C)~=1 | type(D)~=1) then
        error('check input types');
    end
    if (length(size(A))~=2 | length(size(B))~=2 | length(size(C))~=2 | length(size(D))~=2) then
        error('input must be 2d matrices');
    end
    if (norm(imag(A))~=0 | norm(imag(B))~=0 | norm(imag(C))~=0 | norm(imag(D))~=0) then
        error('input must be real matrices');
    end
    //cross checking dimensions of matrix
    if size(D)~=[1,1] then
        error('for single input single output, D must be 1 by 1');
    end
    [n,k]=size(B);
    if k~=1 then
        error('for single input single output, B must be column matrix');
    end
    [n,k]=size(C);
    if n~=1 then
        error('for single input single output, C must be row matrix');
    end
    if size(A)~=[1,1] then
        error('A must be square matrix');
    end
    //obtaining the transfer function(continuous)
    tf=ss2tf(syslin('c',A,B,C,D));
    //factorising the numerator and the denominator into second order systems
    [zero,gn]=sosbreak(numer(tf));//function is defined in the same folder
    [pole,gd]=sosbreak(denom(tf));
    //reducing each pair of second order in the necessary form
    sos=[];
    for i=[1:length(pole)]
        den=pole(i);
        // if no polynomial is left in the numerator
        if i>length(zero) then
            //z^(-1) is in the numerator if the denominator in linear
            if degree(den)==1 then
                b=[0,1,0];
            //z^(-2) is in the numerator if the denominator is quadratic
            else
                b=[0,0,1];
            end
        //if polynomial is left
        else
            b=coeff(zero(i));//obtain coefficient of the polynomial
            b=[b,zeros(1,degree(den)+1-length(b))];//add a zero in the end if the numerator is linear and denominator is quadratic
            b=b($:-1:1);//reverse the coefficients
            b=[b,zeros(1,3-length(b))];//add a zero if both numerator and denominator are linear
        end
        a=coeff(den);//coefficient of the denominator
        a=a($:-1:1);//reversing the coefficients
        a=[a,zeros(1,3-length(a))];//adding zeros if the denominator is linear
        v=[b,a];
        sos=[sos;v]//adding the second order sub-system
    end
    
    g=gn/gd;//computing the gain
    
endfunction
