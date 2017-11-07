function [s,g] = cell2sos(c)
//Converts a cell array to a second order section matrix 
//Calling Sequences
//s=cell2sos(c)
//[s,g]=cell2sos(c)
//Parameters
//c
//A cell array
//g
//The scalar gain
//Description
//s=cell2sos(c) converts a a cell array c = { {B1},{A1}, {B2},{A2}, ... {BL},{AL}}
//to an L-by-6 second-order-section matrix s given by:
//       s =   [B1 A1
//               B2 A2
//                ...
//               BL AL]
//numerator vector Bi and denominator vector Ai contains the coefficients of a 
//linear or quadratic polynomial. If the polynomial is linear, the coefficients
//zero-padded on the right.
//[s,g]=cell2sos(c) estimates the gain from the leading term of the cell array
//c={ {[g1,g2]},{B1},{A1}, {B2},{A2}, ... {BL},{AL}} to give g=g1/g2 as the gain
//Example
//c=cell(1,5);
// 
//c(1,1).entries=[2, 1];
// 
//c(1,2).entries=rand(1,3);
// 
//c(1,3).entries=rand(1,3);
// 
//c(1,4).entries=rand(1,3);
// 
//c(1,5).entries=rand(1,3);
//
// c  =
//         column 1 to 3
// 
//![2,1]  [0.2113249,0.7560439,0.0002211]  [0.3303271,0.6653811,0.6283918]  !
// 
//         column 4 to 5
// 
//![0.8497452,0.6857310,0.8782165]  [0.0683740,0.5608486,0.6623569]  !
//[s,g]=cell2sos(c);
//s  =
// 
//         column 1 to 5
// 
//    0.2113249    0.7560439    0.0002211    0.3303271    0.6653811  
//    0.8497452    0.6857310    0.8782165    0.0683740    0.5608486  
// 
//         column 6
// 
//    0.6283918  
//    0.6623569  
// 
//g  =
// 
//    2.  
//Author
//Ankur Mallick
    if(argn(2)~=1) then
        error("Wrong number of input arguments");
    end
    
    L=prod(size(c));
    for i=1:L
        if(type(c(i))~=17)
            error('Cell contents must themselves be cell objects');
        end
    end
    if (argn(1)==2)
        d=c(1).entries;
        if(length(d)==2)
            g1=d(1);
            g2=d(2);
            g=g1/g2;
            c=c(2:L);
        else
            g=1;
        end
    end
    L=prod(size(c));
    s=zeros(L/2,6);
    for i=1:2:L-1
        j=ceil(i/2)
        b=c(i).entries;
        a=c(i+1).entries;
        b=b(:).';
        a=a(:).';
        b=[b,zeros(1,3-length(b))];
        a=[a,zeros(1,3-length(b))];
        s(j,:)=[b,a];
    end
endfunction
