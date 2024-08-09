/*
Description
    The inverse of the permute function.
    The expression
        ipermute (permute (A, perm), perm)
    returns the original array A.
Calling Sequence
    ipermute (A, iperm)
*/
function B = ipermute(A, perm)
    // ipermute : Inverse permute the dimensions of a matrix A.
    // B = ipermute(A, perm) returns the array A with dimensions inverted
    // according to the permutation vector `perm`.
    // Validate the permutation vector
    if max(size(perm)) ~= ndims(A) || or(gsort(perm, "g", "i") ~= 1:ndims(A))
        error('Permutation vector must contain unique integers from 1 to ndims(A).');
    end
    // Compute the inverse permutation vector
    invPerm = zeros(size(perm,1),size(perm , 2));
    for i = 1:max(size(perm))
        invPerm(perm(i)) = i;
    end
    // Use the permute function with the inverse permutation
    B = permute(A, invPerm);
endfunction
