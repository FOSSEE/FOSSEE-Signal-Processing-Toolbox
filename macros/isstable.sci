function isstab=isstable(varargin)
// Check for the stability of a discrete-time system.
//
// Syntax
//   flag = isstable(b, a)
//   flag = isstable(sos)
//
// Parameters
// b: Numerator coefficients of the filter.
// a: Denominator coefficients of the filter.
// sos: K x 6 second-order section matrix. Each row corresponds to the coefficients of a second-order filter.
//
// Description
// The `isstable` function checks whether a discrete-time system is stable. 
// A discrete-time system is stable if all poles of the system function are inside the unit circle in the z-plane.
//
// - When called with `b` and `a`, the function checks the stability of the filter defined by these coefficients.
// - When called with `sos`, the function checks the stability of the filter defined by the second-order section matrix.
//
// The function returns `flag = 1` if the system is stable, and `flag = 0` otherwise.
//
// Examples
// flag = isstable([1 2 0], [1 5 6])

    [nargout,nargin]=argn();
if (nargin==2) then//(a,b) is the input
    a=varargin(1);
    b=varargin(2);
    //verifying type and length of input
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
elseif (nargin==1) then//sos form is given as input
    sos=varargin(1);
    v=size(sos);
    if(v(1)>1) then
        //verifying type and length of input
        if type(sos)~=1 then
            error('check input type');
        end

        if length(v)>2 then
            error('check input dimension');
        end
        if v(2)~=6 then
            error('When first input is a matrix, it must have exactly 6 columns to be a valid SOS matrix.');
        end
        a=1;b=1;
        //converting it to rational form
        for i=[1:v(1)]
            a=convol(a,sos(i,1:3));
            b=convol(b,sos(i,4:6));
        end
    else
        b=1;
    end
else
    error('no. of inputs not matching');
end
if length(b)==1 then
    isstab=1;
else
    poly_a=inv_coeff(a);//constructing numerator polynomial
    poly_b=inv_coeff(b);//constructing denominator polynomial
    gc=gcd([poly_a,poly_b]);//computing gcd to remove common roots
    [r,den]=pdiv(poly_b,gc);//dividing off gcd
    time_constant=min(abs(roots(den)));//finding the minumum magnitude pole
    if time_constant<=1 then//pole magnitude should be greater than 1
        disp('unstable system');
        isstab=0;
    else
        isstab=1;
    end
end
endfunction
