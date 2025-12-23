function islin=islinphase(varargin)
// Determine whether a filter has linear phase.
//
// Syntax
//   flag = islinphase(b, a)
//   flag = islinphase(sos)
//   flag = islinphase(..., tol)
//
// Parameters
// b: Numerator coefficients of the filter.
// a: Denominator coefficients of the filter.
// sos: K x 6 second-order section matrix.
// tol: (optional) Tolerance for phase response similarity. Default is 0.
//
// Description
// The `islinphase` function determines whether a filter has linear phase. 
// It returns `flag = 1` if the filter is linear phase, otherwise it returns `flag = 0`.
//
// - When called with `b` and `a`, the function checks the linear phase property of the filter defined by these coefficients.
// - When called with `sos`, the function checks the linear phase property of the filter defined by the second-order section matrix.
// - The optional `tol` parameter specifies the tolerance for phase response similarity.
//
// Examples
// flag = islinphase([0, 1, 2, 2, 1, 0], 1)
//
// Authors
// Parthasarathi Panda  ( parthasarathipanda314@gmail.com )
// 

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
    if length(b)==1 then
        err=a-a($:-1:1);
        maxerr=max(err.*conj(err));
        if err<=tol then
            islin=1;
        else
            islin=0;
        end
    else
        islin=0;
    end

endfunction
