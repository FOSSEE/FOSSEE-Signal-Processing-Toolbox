function [y,perm,nshifts] = shiftdata(x,dim)
//Shifts data by rearranging dimensions
//Calling sequence
//[y,perm,nshifts]=shiftdata(x,dim)
//[y,perm,nshifts]=shiftdata(x)
//Parameters
//x
//A vector matrix or n-dimensional array
//dim
//The dimension to be shifted to the first column
//Description
//[y,perm,nshifts]=shiftdata(x,dim)
//Shifts the entries along dimension dim in x to the first column and returns the permutation vector in perm
//[y,perm,nshifts]=shiftdata(x)
//Shifts the entries along dimension dim in x to the first column and returns the number of shifts in nshifts
//Examples
// //When dim is specified:
//x=testmatrix('magi',3)
//x  =
// 
//    8.    1.    6.  
//    3.    5.    7.  
//    4.    9.    2.
//[y,perm,nshifts] = shiftdata(x,2)
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
// //When dim is not specified:
//x=1:5
//x  =
// 
//    1.    2.    3.    4.    5.
// [y,perm,nshifts] = shiftdata(x)
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
//See also
//permute
//unshiftdata
//Author
//Ankur Mallick
    funcprot(0);
    if(argn(2)<1|argn(2)>2)
        error('Incorrect number of input arguments.');
    elseif(argn(2)==1|size(dim)==0)
        perm=[];
        S=size(x);
        v=find(S>1,1);
        y=matrix(x,S(v:length(S)));
        nshifts=v-1;
    else
        S=size(x);
        perm=1:1:length(S);
        perm(dim)=[];
        perm=[dim perm];
        y=permute(x,perm);
        nshifts=[];
    end
endfunction
