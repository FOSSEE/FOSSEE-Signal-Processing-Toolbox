function ismin=isminphase(varargin)
// Determine whether a filter is minimum phase.
//
// Syntax
//   flag = isminphase(b, a)
//   flag = isminphase(sos)
//   flag = isminphase(..., tol)
//
// Parameters
// b: Numerator coefficients of the filter.
// a: Denominator coefficients of the filter.
// sos: K x 6 second-order section matrix.
// tol: (optional) Tolerance used to determine when two numbers are close enough to be considered equal.
//
// Description
// The `isminphase` function determines whether the given system function is a minimum phase system. 
// A minimum phase system means all zeros of the transfer function are inside the unit circle in the z-plane, 
// and all poles must be within the unit circle for stability and causality.
//
// Examples
// flag = isminphase([1 -0.3 0.02], 1)
// 
// Authors
// Parthasarathi Panda ( parthasarathipanda314@gmail.com )

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
            a=convol(a,sos(i,1:3));
            b=convol(b,sos(i,4:6));
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
    maxpole=max(abs(roots(den)));
    maxzero=max(abs(roots(num)));
    if length(b)==1 then
        if length(a)==1 then
            ismin=1;
        elseif maxzero<1 then
            ismin=0;
        else
            ismin=1;
        end
    elseif maxpole>1 then
        if length(a)==1 then
            ismin=1;
        elseif maxzero>1 then
            ismin=1;
        else
            ismin=0;
        end
    else
        ismin=0;
    end
endfunction
