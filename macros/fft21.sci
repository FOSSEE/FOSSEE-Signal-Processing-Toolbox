/* Description
        Calculates the two-dimensional discrete Fourier transform of A using a Fast Fourier Transform algorithm.
        It performs two-dimentional FFT on the matrix A. You can use the variables m and n to specify the number of rows and columns
        of A that you want to use. If either of these variables is larger than the size of A,
        then A will be resized, and zeros will be added as padding.
        If A is a multi-dimensional matrix, the function will treat each two-dimensional sub-matrix of A separately.
    Calling Sequence
        fft21 (A)
        fft21 (A, m, n)
    Parameters 
        A: input matrix
        m: number of rows of A to be used
        n: number of columns of A to be used
    Examples
        A = [1 2 3; 4 5 6; 7 8 9]
        m = 4
        n = 4
        fft21 (A, m, n)
        ans =
            45 +  0i   -6 - 15i   15 +  0i   -6 + 15i
            -18 - 15i   -5 +  8i   -6 -  5i    5 -  4i
            15 +  0i   -2 -  5i    5 +  0i   -2 +  5i
            -18 + 15i    5 +  4i   -6 +  5i   -5 -  8i */
function res = fft21 (A, m, n)
    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 1 | rhs > 3)
        error("Wrong number of input arguments.")
    end
    siz=size(A)
    len=length(siz)
    select(rhs)
    case 1 then
        if len>2 then
            last_dim=siz(len)
        else
            last_dim=1
        end
        res=[]
        for i=1:last_dim
            res(:,:,i)=fft(A(:,:,i),-1)
        end
    case 2 then
        error("Wrong number of input arguments.")
    case 3 then
        if len>2 then
            last_dim=siz(len)
        else
            last_dim=1
        end
        res=[]
        for i=1:last_dim
            res(:,:,i)=fft(resize_matrix(A(:,:,i),m,n),-1)
        end;
    end
endfunction
