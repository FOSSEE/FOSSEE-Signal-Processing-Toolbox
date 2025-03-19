// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Date of Modification: 13 March 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [M ,iM ]= cummin(varargin)
    // Cumulative minimum
    //
    // Calling Sequence
    // M = cummin(A)
    //      returns the cumulative minimum of the arguments of A. The dimension 
    //      of M is same as the dimension of A. If A is a 2D matrix, the operation
    //      is performed along the columns. For a hypermatrix, the operation is
    //      performed along the first non-zero dimension
    // M = cummin(A,dim)
    //      The operation is performed along the dimension specified by dim
    // M = cummin(_,direction)
    //      direction specifies as the direction of operation
    //
    // [M , iM] = cummin(..) 
    //      If called with two output arguments the index of the minimum value is also returned.
    // Parameters
    // A - real|complex numbers - vector|matrix
    //     Input Array
    //     For complex elements, cummin compares the magnitude of elements. If
    //     the magnitude are same, phase angles are compared.
    // dim - positive integer - scalar  
    //     Dimension to operate along
    //     If no dimension is specified, then the default value is the first 
    //     array dimension whose value is greater than 1
    // direction - string flag - 'forward' (default) or 'reverse'
    //     Direction of cumulation
    //     If the direction is forward, cummin works from 1 to end of the active
    //     dimension. Otherwise, it works in the opposite sense
    //
    // Examples
    // 1) Cumulative minimum values in a vector
    //     v = [8 9 1 10 6 1 3 6 10 10]
    //     M = cummin(v)
    //        
    // Expected output: [8 8 1 1 1 1 1 1 1 1]
    //
    [numOutArgs,numInArgs] = argn(0);
    
    // ** Checking number of arguments
    
    if numInArgs<1 | numInArgs>3 then
        msg = "cummin: Wrong number of input argument; 1-3 expected";
        error(77,msg);
    end
    
    if numOutArgs >  2 then
        msg = "cummin: Wrong number of output argument; 1 or 2 expected";
        error(78,msg);
    end
    
    
    // ** Parsing input args **
    
    // defining default arguments
    isForward = %t;
    dim = [];
    directionArg = "";
    A = varargin(1);
    
    // A should contain numeric entries
    if ~(type(A)==1 | type(A)==8 | type(A)==17) then
        msg = "cummin: Wrong type for argument #1 (A); Real or complex entries expected ";
        error(53,msg);
    end
    
    if numInArgs>1 then
        temp = varargin(2);
        if type(temp)==10 then
            // it is the direction argument
            directionArg = temp;
        elseif type(temp)==1 | type(temp)==8 then
            dim = int(temp);
        else
            msg = "cummin: Wrong type for argument #2; Either dim (integer) or direction (string) expected";
            error(53,msg);
        end
    end
    
    if numInArgs>2 then
        directionArg = varargin(3);
        if type(directionArg)~=10 then
            msg = "cummin: Wrong type for argument #3 (direction); String expected";
            error(53,msg);
        end
    end
    
    if isempty(dim) then
        dimArray = 1:ndims(A);
        dim = find(size(A)~=1,1);
    end
    
    // additional checks on dim
    if size(A,dim)==1 then
        M = A;
        return
    end
    
    // extracting direction
    if strcmp(directionArg,"reverse")==0 then
        isForward = %f;
    elseif strcmp(directionArg,"forward")==0 then
        isForward = %t;
    elseif strcmp(directionArg,"")~=0 then
        msg = "cummin: Wrong value for argument #3 (direction)";
        error(53,msg);
    end
    
    sizeA = size(A);
    sizeDim = size(A,dim);
    
    // restructuring A into a 3D matrix with the specified dimension as the middle elements
    
    leftSize = prod(sizeA(1:dim-1));
    rightSize = prod(sizeA(dim+1:$));
    middleSize = sizeDim;
    
    
    A_ = matrix(A,[leftSize,middleSize,rightSize]);
    M_ = zeros(leftSize,middleSize,rightSize);
    
    for i=1:leftSize
        for j=1:rightSize
            M_(i,:,j) = cumminVec(A_(i,:,j),isForward);
        end
    end
    
    M = matrix(M_,sizeA);
    if numOutArgs == 2 then
        // calculating the index 
        // for vectors
        iM = zeros(sizeA(1),sizeA(2));
        for i=1:sizeA(1)
            for j=1:sizeA(2)
                index = find (M(i,j) == A(i,:) )
                iM(i,j) = index(1)
            end
        end
    end
endfunction
    
    
function out = cumminVec(inp,isForward)
    // performs cummin on vector inputs

    if isForward then
        startIndex=1;
        endIndex = length(inp);
        step = 1;
    else
        startIndex=length(inp);
        endIndex = 1;
        step = -1;
    end
    
    if isreal(inp,1e-7) then
        inp = real(inp);
    end
    
    out = zeros(size(inp,1),size(inp,2));
    out(startIndex) = inp(startIndex);

    if isreal(inp) then
        for i=(startIndex+step):step:endIndex

            if isnan(out(i-step)) then
                out(i) = inp(i);
            elseif inp(i)<=out(i-step) then
                out(i) = inp(i);
            else
                out(i) = out(i-step);
            end
        end
    else
        magVec = abs(inp);
        phaseVec = atan(imag(inp),real(inp)); 
        
        // phase - first compare absolute value; then compare phase in [-pi,pi]
        
        prevMag = magVec(startIndex);
        prevPhase = phaseVec(startIndex);
        
        
        for i=(startIndex+step):step:endIndex
            if isnan(out(i-step)) then
                out(i) = inp(i);
                prevMag = magVec(i);
                prevPhase = phaseVec(i);
            elseif magVec(i)<prevMag then
                out(i) = inp(i);
                prevMag = magVec(i);
                prevPhase = phaseVec(i);
            elseif magVec(i)>prevMag then
                out(i) = out(i-step);
            else
                if phaseVec(i)<prevPhase then
                    out(i) = inp(i);
                    prevMag = magVec(i);
                    prevPhase = phaseVec(i);
                else
                    out(i) = out(i-step);
                end
            end
        end
    end
    

endfunction

/*
# tests
w = cummin ([5 4 6 2 3 1]) // passed

[w,iw] = cummin ([5 4 6 2 3 1]) // passed

x = [1 2 3; 4 1 2; 3 5 1];
result = cummin(x) // passed

x = [1 2 3; 4 1 2; 3 5 1];
result = cummin(x, 2) //passsed

x = [1 2 3; 4 1 2; 3 5 1];
[w,iw] = cummin(x, 2) //passsed
*/