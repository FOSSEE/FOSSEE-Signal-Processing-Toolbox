//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com

// This function checks whether given system function is FIR or not

//. Calling Sequence
// fir = isfir(b,a)
// fir = isfir(sos)

// Input Parameters
// a -->denumerator coefficient matrix
// b --> numerator coefficient matrix
// sos --> second order split matrix
// Output parameter
// fir --> fir == 1 if system is FIR , fir == 0 if system is not FIR

//Description
// This function take a system function (in terms of denumerator and numerator coefficient matrix or in term of second order split (sos) matrix) as input and checks

//Example
// 1.)
// fir = isfir([1 -1 1], 1)
//-->fir = isfir([1 -1 1],1)
// fir  =
//
//    1.

//Conclusion : Output of above example is fir = 1 this means system is FIR

function fir=isfir(varargin)
    [nargout,nargin]=argn();
// checking for input in terms of numerator (b) and denumerator (a) coefficient matrices
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
//Checking for input in terms of second orer split (sos) matrix
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
    if length(b)==1 then
        fir=1;
    else
        fir=0;
    end
endfunction
