/*Description
        Calculates the discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
        The FFT is calculated along the first non-singleton dimension of the array. Thus, FFT is computed for each column of D.
        The variable 'N' is an integer that determines the number of elements of 'D' to use.
        If 'N' is larger than the dimension along which the FFT is calculated,
        then 'D' is resized and padded with zeros to match the required size.On the other hand,
        if 'N' is smaller than the size of 'D', then 'D' is truncated to match the required size.
        DIM is an integer specifying the dimension of the matrix along which the FFT is performed.
Calling Sequence
       fft1 (D)
       fft1 (D, N)
       fft1 (D, N, DIM)
Parameters
        D: input matrix
        N: Specifies the number of elements of x to be used
        DIM: Specifies the dimention of the matrix along which the FFT is performed
Examples
        D = [1 2 3; 4 5 6; 7 8 9]
        N = 3
        DIM = 2
        fft1 (D,N,DIM)
        ans =
            6.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
            15.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
            24.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i */
function res =  fft1 (D, N, DIM)
    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 1 | rhs > 3)
        error("Wrong number of input arguments.")
    end
    dimension = size(D);
    // first non-singleton dimension
    nsdim = find(dimension >1,1)
    if isempty(nsdim) then
        nsdim = 1 // default to 1 to avoid error while calling fft
    end    
    select(rhs)
    case 1 then
        res = fft(D, -1, nsdim);
    case 2 then
        if isempty(N) then
            n = size(D, nsdim);
        else
            n = N;
        end
        new_size = size(D);
        new_size(nsdim) = n;
        D = resize_matrix(D, new_size);
        res = fft(D, -1, nsdim);
    case 3 then
        if isempty(N) then
            n = size(D, DIM);
        else
            n = N;
        end
        new_size = size(D);
        new_size(DIM) = n;
        D = resize_matrix(D, new_size);
        res= fft(D, -1, DIM);
        end
endfunction
