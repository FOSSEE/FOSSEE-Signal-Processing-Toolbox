function c = sos2cell(s,g)
//Converts a second order section matrix to a cell array
//Calling Sequences
//c=sos2cell(s)
//c=sos2cell(s,g)
//Parameters
//s
//An L-by-6 matrix where L is the number of sections
//g
//The scalar gain
//Description
//c=sos2cell(s) converts an L-by-6 second-order-section matrix s given by:
//       s =   [B1 A1
//               B2 A2
//                ...
//               BL AL]
//to a cell array c = { {B1},{A1}, {B2},{A2}, ... {BL},{AL}} where each 
//numerator vector Bi and denominator vector Ai contains the coefficients of a 
//linear or quadratic polynomial. If the polynomial is linear, the coefficients
//zero-padded on the right
//c=sos2cell(s,g) adds a leading gain term to the start of the cell array as:
//c={ {[g,1]},{B1},{A1}, {B2},{A2}, ... {BL},{AL}}
//Example
//s=rand(2,6)
// s  =
// 
// 
//         column 1 to 5
// 
//    0.0437334    0.2639556    0.2806498    0.7783129    0.1121355  
//    0.4818509    0.4148104    0.1280058    0.2119030    0.6856896  
// 
//         column 6
// 
//    0.1531217  
//    0.6970851  
// 
//sos2cell(s,2)
// ans  =
// 
// 
// 
//         column 1 to 3
// 
//![2,1]  [0.0437334,0.2639556,0.2806498]  [0.7783129,0.1121355,0.1531217]  !
// 
//         column 4 to 5
// 
//![0.4818509,0.4148104,0.1280058]  [0.2119030,0.6856896,0.6970851]  !
//Author
//Ankur Mallick
    if(argn(2)<2)
        g=[];
    end
    if g==1
        g=[];
    end
    if(~or(type(s)==[1 5 8])|ndims(s)~=2|size(s,2)~=6)
        error('Invalid Entry');
    end
    L=size(s,1);
    if ((L==1)&(~isempty(g))&(s==[1, 0, 0, 1, 0, 0]))
        s=g*s;
        g=[];
    end
    c=cell(1,2*L);
    k=0;
    if(~isempty(g))
        c=cell(1,2*L+1);
        c(1,1).entries=[g, 1];
        k=1;
    end
    for i=1:2:2*L
        j=ceil(i/2);
        sa=s(j,1:3);
        ma=max(find(sa~=0));
        sb=s(j,4:6);
        mb=max(find(sb~=0));
        cs=cell(1,2);
        if(~isempty(ma))
            cs(1,1).entries=sa(1:ma);
        else
            cs(1,1).entries=[];
        end
        if(~isempty(mb))
            cs(1,2).entries=sb(1:mb);
        else
            cs(1,2).entries=[];
        end
        c(k+i)=cs(1,1);
        c(k+i+1)=cs(1,2);
    end
endfunction
