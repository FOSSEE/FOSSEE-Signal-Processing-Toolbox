Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
/*Description
    Calculates the inverse two-dimensional discrete Fourier transform of A using a Fast Fourier Transform algorithm.
    It performs inverse two-dimensional FFT on the matrix A. m and n may be used specify the number of rows and columns of A to use. If either of these is larger
    than the size of A, A is resized and padded with zeros.
    If A is a multi-dimensional matrix, each two-dimensional sub-matrix of A is treated separately.
Calling Sequence
     ifft2 (A)
     ifft2 (A, m, n)
Parameters
     A: input matrix
     m: number of rows of A to be used
     n: number of columns of A to be used
Examples
     A= [1 2 3; 4 5 6; 7 8 9]
     m = 4
     n = 4
     ifft2 (A, m, n) --functionCall
     ans =
        2.81250 + 0.00000i  -0.37500 + 0.93750i   0.93750 + 0.00000i  -0.37500 - 0.93750i
        -1.12500 + 0.93750i  -0.31250 - 0.50000i  -0.37500 + 0.31250i   0.31250 + 0.25000i
        0.93750 + 0.00000i  -0.12500 + 0.31250i   0.31250 + 0.00000i  -0.12500 - 0.31250i
        -1.12500 - 0.93750i   0.31250 - 0.25000i  -0.37500 - 0.31250i  -0.31250 + 0.50000i
*/
function res = ifft2(A, m, n)
    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 1 | rhs > 3)
        error("Wrong number of input arguments.")
    end
    size_x=size(A)
    len=length(size_x)
    //to figure out size of multidimensional array
    if len>2 then
        last_dim=size_x(len)
    else
        last_dim=1
    end    
    select(rhs)
        case 1 then
        res=[]
        for i=1:last_dim //treating each submatrix seperately
            res(:,:,i)=fft(A(:,:,i),1)
        end
    case 2 then
        error("Wrong number of input arguments.")
    case 3 then
        res=[]
        for i=1:last_dim 
            res(:,:,i)=fft(resize_matrix(A(:,:,i),m,n),1)
        end
    end
endfunction
