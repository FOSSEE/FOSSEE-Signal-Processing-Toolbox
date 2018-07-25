//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com

//ss2sos converts a state-space representation of a given digital filter to an equivalent second-order section representation.

////Example:
//a =[0.5095,0,0,0,0;
//0.3007, 0.2260, -0.3984, 0, 0;
//0.0977, 0.3984, 0.8706, 0, 0;
//0.0243, 0.0991, 0.4652, 0.5309, -0.4974;
//0.0079, 0.0322, 0.1512, 0.4974, 0.8384];
//
//
//b =[0.6936 0.1382 0.0449 0.0112 0.0036]'
//
//
//c =[0.0028 0.0114 0.0534 0.1759 0.6500]
//
//
//d =0.0013

//[sos,g]=ss2sos(a,b,c,d)
//Expected output:
//g  =
 //    0.0013
// sos  =
//  1.    1.2679417    0.6443293    1.  - 1.0966    0.3554782
//  1.    3.1480112    3.2063892    1.  - 1.3693    0.6925133
//  1.    0.4742625    0.           1.  - 0.5095    0.
//



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
    if size(A)==[1,1] then
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
