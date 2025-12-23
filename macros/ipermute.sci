function B = ipermute(A, perm)
// Inverse of the permute function.
//
// Syntax
//   B = ipermute(A, perm)
//
// Parameters
// A: Input array.
// perm: Permutation vector specifying the order of dimensions.
//
// Description
// The `ipermute` function reverses the effect of the `permute` function. 
// It rearranges the dimensions of the input array `A` according to the inverse of the permutation vector `perm`.
//
// The expression:
//   ipermute(permute(A, perm), perm)
// returns the original array `A`.
//
// Examples
// A = [1, 2; 3, 4]
// perm = [2, 1]
// B = ipermute(permute(A, perm), perm)
// 
    
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
