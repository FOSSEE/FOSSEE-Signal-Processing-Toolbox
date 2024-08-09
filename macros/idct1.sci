/*Description
    This function computes the inverse discrete cosine transform of input X.
    If N is given, then X is padded or trimmed to length N before computing the transform.
    If X is a matrix, compute the transform along the columns of the the matrix.
    The transform is faster if X is real-valued and even length.
Calling Sequence
    Y = idct1(X)
    Y = idct1(X, N)
Parameters
    X: Matrix or integer
    N: If N is given, then X is padded or trimmed to length N before computing the transform.
Examples
    idct1([1,3,6])
    ans =
        5.1481604  - 4.3216292    0.9055197
*/
function y = idct1(x,n)
    funcprot(0);
    rhs=argn(2);
    if (rhs<1 | rhs>2) then
        error("Wrong number of input arguments.");
    end
    nsdim=1;
    siz=size(x);
    len=length(siz);
    for i=1:len
        if siz(i) ~= 1 then 
            nsdim=i//calculating along non-singlton dimension
            break;
        end;
    end;
    select(rhs)
    case 1 then
        y=idct(x,nsdim);
    case 2 then
        siz(nsdim)=n;
        y=idct(resize_matrix(x,siz),nsdim)
    end;
endfunction
