
function y = ifftn(A, SIZE)
// Compute the inverse N-dimensional discrete Fourier transform.
//
// Syntax
//   Y = ifftn(A)
//   Y = ifftn(A, SIZE)
//
// Parameters
// A: Input matrix.
// SIZE: (optional) Dimensions of the matrix to be used. If an element of SIZE is smaller than the corresponding dimension of A, the dimension of A is truncated. If larger, A is resized and padded with zeros.
//
// Description
// Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
//
// Examples
// ifftn([2,3,4])
// 

    funcprot(0);
    funcprot(0);
    rhs = argn(2)
    if(rhs<1 | rhs>2)
        error("Wrong number of input arguments.");
    end
    select(rhs)
    case 1 then
        y=fft(A,1);
    case 2 then
        // Check if A needs resizing
        if size(A) == SIZE then
            // No resizing needed
            break;
        elseif length(size(A)) ~= length(SIZE) then
            error("Output size must have at least Ndims");
        else
            // Resize A using the resize_matrix function
            A = resize_matrix(A, SIZE);
        end
        y = fft(A,1);
    end
    y = clean( y ) ;
endfunction

