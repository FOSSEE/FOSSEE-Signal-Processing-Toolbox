function res =  ifft1 (x, n, dim)
// Compute the inverse discrete Fourier transform.
//
// Syntax
//   ifft1(x)
//   ifft1(x, n)
//   ifft1(x, n, dim)
//
// Parameters
// x: Input matrix.
// n: (optional) Number of elements of x to use. If n is larger than the dimension along which the inverse FFT is calculated, x is resized and padded with zeros. If smaller, x is truncated.
// dim: (optional) Dimension of the matrix along which the inverse FFT is performed.
//
// Description
// Calculates the inverse discrete Fourier transform of a matrix using a Fast Fourier Transform algorithm. The inverse FFT is calculated along the first non-singleton dimension of the array.
//
// Examples
// x = [1 2 3; 4 5 6; 7 8 9]
// n = 3
// dim = 2
// ifft1(x, n, dim)   
// 

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

    
