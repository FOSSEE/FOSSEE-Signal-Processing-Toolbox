//isstable True for stable filter
//  FLAG = ISSTABLE(B,A) returns a logical output, FLAG, equal to TRUE if
//  the filter specified by numerator coefficients B, and denominator
//  coefficients A, is stable. Input vectors B, and A define a filter with
//  transfer function:
//
//              jw               -jw              -jmw
//       jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
//    H(e) = ---- = ------------------------------------
//              jw               -jw              -jnw
//           A(e)    a(1) + a(2)e + .... + a(n+1)e
//
//  FLAG = ISSTABLE(SOS) returns TRUE if the filter specified using the
//  second order sections matrix, SOS, is stable. SOS is a Kx6 matrix,
//  where the number of sections, K, must be greater than or equal to 2.
//  Each row of SOS corresponds to the coefficients of a second order
//  filter. From the transfer function displayed above, the ith row of the
//  SOS matrix corresponds to [bi(1) bi(2) bi(3) ai(1) ai(2) ai(3)].
//  Calling Syntax
//  flag=isstable(b,a);
//  flag=isstable(sos);
//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function isstab=isstable(varargin)
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
