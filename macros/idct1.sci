function y = idct1(x,n)
// Compute the inverse discrete cosine transform.
//
// Syntax
//   Y = idct1(X)
//   Y = idct1(X, N)
//
// Parameters
// X: Input matrix or integer.
// N: (optional) If N is given, X is padded or trimmed to length N before computing the transform.
//
// Description
// Computes the inverse discrete cosine transform of input X. If X is a matrix, the transform is computed along the columns of the matrix. The transform is faster if X is real-valued and of even length.
//
// Examples
// idct1([1, 3, 6])
// 

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
