/* Description
    Calculates the inverse discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
    The inverse FFT is calculated along the first non-singleton dimension of the array. Thus, inverse FFT is computed for each column of x.
    n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the inverse FFT is calculated, then x is resized and padded with zeros.
    Similarly, if n is smaller, then x is truncated.
    dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed.
Calling Sequence
        ifft1 (x)
        ifft1 (x, n)
        ifft1 (x, n, dim)
Parameters
        x: input matrix
        n: Specifies the number of elements of x to be used
        dim: Specifies the dimention of the matrix along which the inverse FFT is performed
Examples
        x = [1 2 3; 4 5 6; 7 8 9]
        n = 3
        dim = 2
        ifft1 (x, n, dim)
        ans =
        2.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
        5.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
        8.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i */
function res =  ifft1 (x, n, dim)
    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 1 | rhs > 3)
        error("Wrong number of input arguments.")
    end
    dimension = size(x);
    nsdim = 1;
    for i = 1:length(dimension)
        if dimension(i) ~= 1 then
            nsdim = i;
            break;
        end
    end
    select(rhs)
    case 1 then
        res=fft(x,1,nsdim)
    case 2 then
        if isempty(n) then
            res=fft(x,1,nsdim)
        else
            dimension(nsdim)=n;
            res=fft(resize_matrix(x,dimension),1,nsdim)
        end
    case 3 then
        if isempty(n) then
            res=fft(x,1,dim)
        else
            if (length(dimension) <dim )then
                error("ifft1: DIM must be a valid dimension along which to perform FFT")
            end
            dimension(dim)=n;
           res=resize_matrix(x,dimension);
            res=fft(res,1,dim);
        end
    end
endfunction

    
