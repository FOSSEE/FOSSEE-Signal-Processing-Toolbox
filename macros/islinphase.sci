//islinphase Determine whether filter has linear phase

// Calling Syntax and Parameter description
//flag = islinphase(b,a)
//takes input as numerator and denumerator coefficint matrices and returns flag =1 if filter is linear phase else return flag = 0

//flag = islinphase(sos)
//takes input as K x 6 second order split (sos) matrix and returns flag =1 if filter is linear phase else returns flag =0

//flag = islinphase(...,tol)
// tol -->this takes tolerence in similarities between two numbers in phase respose

//Example :
//flag = islinphase([0 1 2 2 1 0],1)
//Output:
//flag  =

//    1.

//conclusion : output of above example is flag = 1 means filter is linear phase which must be as example is of symmetric linear phase fir filter

//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com

function islin=islinphase(varargin)
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
