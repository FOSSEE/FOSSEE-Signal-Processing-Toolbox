function M = fht(D, N, DIM)
// Fast Hartley transform of real input D
//
// Syntax
//   M = fht(D)
//   M = fht(D, N)
//   M = fht(D, N, DIM)
//
// Parameters
// D: Input data (real matrix or vector).
// N: Number of elements of D to be used for the transform (optional).
// DIM: Dimension along which the transform is to be computed (optional).
//
// Description
// This function computes the Fast Hartley Transform (FHT) of the input signal `D`.
// If D is a matrix, the Hartley transform is calculated along the columns by default.
// If N is specified, the first N elements along the specified dimension are used for the transform.
// If DIM is specified, the transform is calculated along the specified dimension.
//
// Examples
// M = fht(1:4)
//
// See also
//  fft
//


    funcprot(0);
    rhs = argn(2);
    if rhs < 1 | rhs > 3 then
        error("Wrong number of input arguments.")
    end
    // The fht will be calculated along the first non-singleton dimension of the array i.e along the columns by default.
    dimension = size(D);
    nsdim = 1;
    for i = 1:length(dimension)
        if dimension(i) ~= 1 then
            nsdim = i;
            break;
        end
    end
    // Process input arguments
    select(rhs)
    case 1 then
        M = fft(D, -1, nsdim);
    case 2 then
        if isempty(N) then
            n = size(D, nsdim);
        else
            n = N;
        end
        new_size = size(D);
        new_size(nsdim) = n;
        D = resize_matrix(D, new_size);
        M = fft(D, -1, nsdim);
    case 3 then
        if isempty(N) then
            n = size(D, DIM);
        else
            n = N;
        end
        new_size = size(D);
        new_size(DIM) = n;
        D = resize_matrix(D, new_size);
        M = fft(D, -1, DIM);
    end
    // Return real part of the result
    M = real(M) - imag(M);
endfunction
