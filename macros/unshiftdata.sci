function y = unshiftdata(x,perm,nshifts)
//Inverts the effect of shiftdata
//Calling sequence
//y=unshiftdata(x,perm,nshifts)
//Parameters
//x
//A vector matrix or n-dimensional array
//perm
//Permutation applied by shiftdata to obtain x
//nshifts
//The number of shifts applied by shiftdata to obtain x
//Description
//y=unshiftdata(x,perm,nshifts)
//Applies the permutation perm or number of shifts nshifts on x to invert shiftdata
//Examples
//x=testmatrix('magi',3)
//x  =
// 
//    8.    1.    6.  
//    3.    5.    7.  
//    4.    9.    2.
//[y,perm,nshifts] = shiftdata(x,2) //Shifts dimension 2
//nshifts  =
// 
//     []
// perm  =
// 
//    2.    1.  
// y  =
// 
//    8.    3.    4.  
//    1.    5.    9.  
//    6.    7.    2.  
//z=unshiftdata(y,perm,nshifts)
//z  =
// 
//    8.    1.    6.  
//    3.    5.    7.  
//    4.    9.    2.
//
//x=1:5
//x  =
// 
//    1.    2.    3.    4.    5.
// [y,perm,nshifts] = shiftdata(x) //Shifts first non-singleton dimension
//nshifts  =
// 
//    1.  
// perm  =
// 
//     []
// y  =
// 
//    1.  
//    2.  
//    3.  
//    4.  
//    5.
////z=unshiftdata(y,perm,nshifts)
//z  =
// 
//    1.    2.    3.    4.    5.
//See Also
//permute
//shiftdata
//Author
//Ankur Mallick
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
