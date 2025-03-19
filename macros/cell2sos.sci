// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author: Abinash Singh Under FOSSEE Internship
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
/*
Calling Sequence :
    sos = cell2sos(cll)
    [sos,g] = cell2sos(cll)
Description 
    sos = cell2sos(cll) generates a matrix sos containing the coefficients of the filter system described by the second-order section cell array cll.
    [sos,g] = cell2sos(cll) also returns the scale gain g.

    Second-order section cell-array representation, specified as a cell array.

Input Argument:    
    For a filter system with L sections, specify 'cll' using this structure:
    
    * Cell array with L elements — For unity-gain filter systems. Each element of the cell 
      array corresponds to a second-order section. The kth cell array element of 'cll'
    
        cll{k} = {[b_0k b_1k b_2k] [1 a_1k a_2k]}
    
      contains the coefficients from the kth second-order-section of the filter system H(z):
    
        H(z) = product(k=1 to L) H_k(z) 
             = product(k=1 to L) (b_0k + b_1k*z^(-1) + b_2k*z^(-2))/(1 + a_1k*z^(-1) + a_2k*z^(-2))
    
    * Cell array with L+1 elements — If the gain of the filter system is different from 1. 
      The first element of 'cll' contains the system gains at the numerator (g_n) and at 
      the denominator (g_d). Then, the function appends each element of the cell array for 
      the corresponding second-order section.
    
      The first and the k+1th cell array element of 'cll'
    
        cll{1} = {g_n g_d}
        cll{k+1} = {[b_0k b_1k b_2k] [1 a_1k a_2k]}
    
      contain the system gain and the coefficients from the kth second-order section of 
      the filter system H(z), respectively, such that:
    
        H(z) = (g_n/g_d) * product(k=1 to L) H_k(z)
             = (g_n/g_d) * product(k=1 to L) (b_0k + b_1k*z^(-1) + b_2k*z^(-2))/(1 + a_1k*z^(-1) + a_2k*z^(-2))
    
Output Argument:             
         Second-order section representation, returned as an L-by-6 matrix, where L is the 
         number of second-order sections. The matrix
        
           sos = [b_01  b_11  b_21   1   a_11  a_21]
                 [b_02  b_12  b_22   1   a_12  a_22]
                 [  ⋮     ⋮     ⋮     ⋮    ⋮     ⋮ ]
                 [b_0L  b_1L  b_2L   1   a_1L  a_2L]
        
         represents the second-order sections of H(z):
        
           H(z) = g * product(k=1 to L) H_k(z)
                = g * product(k=1 to L) (b_0k + b_1k*z^(-1) + b_2k*z^(-2))/(1 + a_1k*z^(-1) + a_2k*z^(-2))
*/

function [s,g] = cell2sos(c)
       if(argn(2)~=1) then
            error("cell2sos: Wrong number of input arguments");
        end
        L=prod(size(c));
        k=1
        for i=1:L
            if(type(c(i))~=17)
                error('cell2sos: Cell contents must themselves be cell objects');
            end
        end
        gain_p = 0
        if length(cell2mat(c{1}))== 2 then
            gain_vec=cell2mat(c{1})
            k=gain_vec(1)/gain_vec(2)
            L=L-1
            gain_p=1
        end    
        s = zeros(L,6);
        for i=1:L
            if gain_p
                s(i,:)=cell2mat(cll{i+1})
            else
                s(i,:)=cell2mat(cll{i}) 
            end
        end
        if nargout < 2 then
            s(1,1:3)= k * s(1,1:3)
        else
            g=k;
        end    
endfunction

/* 
cll = {{[3 6 7] [1 1 2]} 
       {[1 4 5] [1 9 3]}
       {[2 7 1] [1 7 8]}};
sos = cell2sos(cll)   // passed

cll = {{1 2} {[3 6 7] [1 1 2]} 
       {[1 4 5] [1 9 3]}
       {[2 7 1] [1 7 8]}};
sos = cell2sos(cll)   // passed

*/