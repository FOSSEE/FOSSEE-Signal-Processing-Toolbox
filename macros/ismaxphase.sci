//ismaxphase Determine whether filter is maximum phase
//Syntax
//flag = ismaxphase(b,a)
//flag = ismaxphase(sos)
//flag = ismaxphase(...,tol)
// b and a are the vectors containing zero and pole coefficients respectively
//tol, tolerance is used to determine when two numbers are close enough to be considered equal. 
//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function ismax=ismaxphase(varargin)
    [nargout,nargin]=argn();
    if (nargin==2) then
        a=varargin(1);
        b=varargin(2);
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
    else
        error('no. of inputs not matching');
    end
    poly_a=inv_coeff(a);
    poly_b=inv_coeff(b);
    z=inv_coeff([1,0]);
    gc=gcd([poly_a,poly_b]);
    [r,den]=pdiv(poly_b,gc);
    [r,num]=pdiv(poly_a,gc);
    maxpole=min(abs(roots(den)));
    minzero=max(abs(roots(num)));
    if length(a)==1 then
        if length(b)==1 then
            ismax=0;
        elseif minzero>1 then
            ismax=0;
        else
            ismax=1;
        end
    elseif maxpole>1 then
        if length(b)==1 then
            ismax=0;
        elseif minzero>1 then
            ismax=0;
        else
            ismax=1;
        end
    else
        ismax=0;
    end
endfunction
