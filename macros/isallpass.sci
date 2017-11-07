//isallpass Determine whether filter is allpass

//Calling Syntax
//flag = isallpass(b,a)
//flag = isallpass(sos)
//flag = isallpass(...,tol)
// b and a are the vectors containing zero and pole coefficients respectively
//tol, tolerance is used to determine when two numbers are close enough to be considered equal. 
//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function isall=isallpass(varargin)
    [nargout,nargin]=argn();
    if (nargin==2) then
        v=size(varargin(1));
        if (v(2)~=6) | (v(2)==6 & v(1)==1) then
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
            tol=0;
        else
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
            tol=varargin(3);
            if (type(tol)~=1) then
                error('check input type');
            end
            if (size(tol)~=[1,1]) then
                error('check input dimension');
            end
        end
    elseif (nargin==1) then
        tol=0;
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
    elseif (nargin==3) then
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
        tol=varargin(3);
        if (type(tol)~=1) then
            error('check input type');
        end
        if (size(tol)~=[1,1]) then
            error('check input dimension');
        end
    else
        error('no. of inputs not matching');
    end

    poly_a=inv_coeff(a($:-1:1));
    poly_b=inv_coeff(b);
    gc=gcd([poly_a,poly_b]);
    [r,den]=pdiv(poly_b,gc);
    [r,num]=pdiv(poly_a,gc);
    poles=roots(den);
    zerosinv=roots(num);
    //sorting the zeros and poles to facilitate comparision
    [l,k]=gsort(imag(poles));
    poles=poles(k);
    [l,k]=gsort(real(poles));
    poles=poles(k);
    [l,k]=gsort(imag(poles));
    zerosinv=zerosinv(k);
    [l,k]=gsort(real(poles));
    zerosinv=zerosinv(k);
    maxerr=max((poles-conj(zerosinv)).*conj(poles-conj(zerosinv)));
    if zerosinv==[] & poles==[] then
        isall=1;
    elseif maxerr<=tol then
        isall=1;
    else
        isall=0;
    end

endfunction
