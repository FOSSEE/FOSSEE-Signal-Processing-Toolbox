//filtord Filter order
//Calling Syntax
//n = filtord(b,a) 
//n = filtord(sos) 
//n = filtord(d)
//n = filtord(b,a) returns
//the filter order, n, for the causal rational
//system function specified by the numerator coefficients, b,
//and denominator coefficients, a.
//n = filtord(sos) returns
//the filter order for the filter specified by the second-order sections
//matrix, sos. sos is a K-by-6
//matrix. The number of sections, K, must be greater
//than or equal to 2. Each row of sos corresponds
//to the coefficients of a second-order filter. The ith
//row of the second-order section matrix corresponds to [bi(1)
//bi(2) bi(3) ai(1) ai(2) ai(3)].
//n = filtord(d) returns
//the filter order, n, for the digital filter, d.
//Use the function designfilt to
//generate d.
//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function m=filtord(varargin)
    [nargout,nargin]=argn();
    narginchk(1,2,argn(2));
    if (nargin==2) then
        a=varargin(1);
        b=varargin(2);
        if(length(b)==0) then
            b=[0];
        end
        if length(a)==0 then
            a=[0];
        end
        
        if type(a)~=1 | type(b)~=1 then
            error('check input type');
        end
        v=size(a);
        if length(v)>2 then
            error('check input dimension');
        end
        v=size(b);
        if length(v)>2 then
            error('check input dimension');
        end
        [n,k]=size(a);
        if k==1 then
            a=a';
        elseif n~=1 then
            error('check input dimension');
        end
        [n,k]=size(b);
        if k==1 then
            b=b';
            k=n;
        elseif n~=1 then
            error('check input dimension');
        end
    elseif (nargin==1) then
        sos=varargin(1);
        if type(sos)~=1 then
            error('check input dimension');
        end
        v=size(sos);
        if length(v)>2 then
            error('check input dimension');
        end
        if v(2)~=6 then
            error('no. of columns must be 6');
        end
        a=1;b=1;
        for i=[1:v(1)]
            a=convol(a,sos(1:3));
            b=convol(b,sos(4:6));
        end
    end
    k=length(a);
    order_a=0;
    for i=k:-1:1
        if (a(1,i)~=0) then
            order_a=i;
            break;
        end
    end
    k=length(b);
    order_b=0;
    for i=[k:-1:1]
        if (b(1,i)~=0) then
            order_b=i;
            break;
        end
    end
    m=max(order_a,order_b)-1;
endfunction
function narginchk(l,h,eip)
    if (eip<l) then
        error("Too few input arguments");
    end
    if(eip>h) then
        error("too many input arguments");
    end
endfunction
