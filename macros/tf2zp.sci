// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
//Original contribution: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function [z,p,k]=tf2zp(num,den)

    // Transfer function to zero pole conversion

    //Calling Sequence
    //[z,p,k]= tf2zp(b,a);

    //Parameters
    //z=zeros of the corrsponding tf
    //p=poles of the corresponding tf
    //k=gain of the tf
    //b=vector containing the numerator coefficients of the transfer function in descending powers of s/z
    //a=vector containing the denominator coefficients of the transfer function in descending powers of s/z

    //For discrete-time transfer functions, it is highly recommended to
    //make the length of the numerator and denominator equal to ensure
    //correct results.  You can do this using the function EQTFLENGTH in
    //the Signal Processing Toolbox.

    //Author : Debdeep Dey

    //Example :
    //b = [1 2 3];
    //a = [4 5 6];
    //[z p k] = tf2zp(b,a)
    //Output:
    //k  =
    //
    //    0.25
    // p  =
    //
    //  - 0.625 + 1.0532687i
    //  - 0.625 - 1.0532687i
    // z  =
    //
    //  - 1. + 1.4142136i
    //  - 1. - 1.4142136i

    numop=argn(1);
    //take only the first row of numerator into consideration
    num=num(1,:);
    //remove leading columns of zeros from numerator
    if ~isempty(num) then
        while(num(:,1)==0 & length(num)>1)
            num(:,1)=[];
        end
    end
    [rd,cod]=size(den);
    [ny,np]=size(num);

    if(rd>1) then
        error("Denominator must be row vector");
    elseif np>cod then
        error("Improper transfer function");
    end
    if (~isempty(den)) then
        coef=den(1);
    else
        coef=1;
    end
    if coef ==0 then
        error("Denominator must have non zero leading coefficient");
    end
    //remove leading columns of zeros from numerator
    if ~isempty(num) then
        while(num(:,1)==0 & length(num)>1)
            num(:,1)=[];
        end
    end

    if (find(den==%inf) ~= [] | find(num==%inf) ~= []) then
        error("Input to ROOTS must not contain NaN or Inf")
    end
    //poles

    p=roots(den);
    //zeros and gain

    k=zeros(ny,1);
    linf=%inf;

    z=linf(ones(np-1,1),ones(ny,1));
    for i=1:ny
        zz=roots(num(i,:));
        if ~isempty(zz), z(1:length(zz), i) = zz; end
        ndx = find(num(i,:)~=0);
        if ~isempty(ndx), k(i,1) = num(i,ndx(1))./coef; end
    end
    z=roots(num);
endfunction
