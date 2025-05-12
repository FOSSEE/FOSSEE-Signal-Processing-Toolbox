function y = unshiftdata(x,perm,nshifts)
// Inverts the effect of shiftdata
//
// Syntax
// y=unshiftdata(x,perm,nshifts)
//
// Parameters
// x : A vector matrix or n-dimensional array
// perm : Permutation applied by shiftdata to obtain x
// nshifts : The number of shifts applied by shiftdata to obtain x
//
// Description
// y=unshiftdata(x,perm,nshifts)
// Applies the permutation perm or number of shifts nshifts on x to invert shiftdata
//
// Examples
// x=testmatrix('magi',3)
// [y,perm,nshifts] = shiftdata(x,2) //Shifts dimension 2
// z=unshiftdata(y,perm,nshifts)
// [y,perm,nshifts] = shiftdata(x) //Shifts first non-singleton dimension
// z=unshiftdata(y,perm,nshifts)
// 
//See Also
//permute
//shiftdata
//
// Author
// Ankur Mallick

    funcprot(0);
    if(argn(2)<1|argn(2)<2|(argn(2)<3&size(perm)==0)|argn(2)>3)
        error('Incorrect number of input arguments.');
    else
        if(size(perm)==0)
            S=size(x);
            S1=[ones(1,nshifts),S]
            y=matrix(x,S1);
        else
            iperm(perm)=1:length(perm);
            y=permute(x,iperm);
        end
    end
endfunction
