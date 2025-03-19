// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author: Abinash Singh Under FOSSEE Internship
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
/*
Calling Sequence :
    cll = sos2cell(s)
    cll = sos2cell(s, g)
Description
    sos2cell converts a second-order section matrix to a cell array representation. 
    The function can handle both unity-gain and non-unity gain filter systems. For non-unity gain systems, the gain factor is stored in the first cell of the output array.
Input Arguments
    s - Second-order section matrix (L-by-6 matrix)
        Each row represents one second-order section
        Must have exactly 6 columns in format: [b0 b1 b2 a0 a1 a2]
        Number of rows (L) represents the number of sections
    g - Gain factor (optional)
        Scalar value representing the system gain
        Default value is 1 if not specified
Output Arguments
    cll - Cell array containing second-order sections
        For unity-gain systems (no gain specified):
        Cell array with L elements
        Each element contains coefficients: {[b0 b1 b2] [a0 a1 a2]}
    For non-unity gain systems:
         Cell array with L+1 elements
         First element contains gain: {g 1}
         Remaining elements contain section coefficients
*/
function cll = sos2cell(s, g)
    if (argn(2) > 2) then
        error("sos2cell: Wrong number of input arguments");
    end  
    gain_inc = 1 ;
    if nargin < 2 then
        g = 1 ;
        gain_inc = 0;
    end        
    [L, n] = size(s);
    if n ~= 6 then
        error("sos2cell: Input matrix must have 6 columns");
    end
    if gain_inc then
        L = L + 1 ;
    end
    cll = cell(1,L);
    start_index=1
    if gain_inc then 
        cll{1} = { g 1};
        start_index = 2 ;
    end
    for i=start_index:L 
        cll{i}={s(i+1-start_index,1:3) s(i+1-start_index,4:6)}
    end
endfunction
/*
sos = [3. 6. 7. 1. 1. 2. ; 1. 4. 5. 1. 9. 3. ; 2. 7. 1. 1. 7. 8.];
cll = sos2cell(sos); // passed

sos = [3. 6. 7. 1. 1. 2. ; 1. 4. 5. 1. 9. 3. ; 2. 7. 1. 1. 7. 8.];
g = 0.5 ;
cll = sos2cell(sos,g); // passed

*/