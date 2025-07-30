function [b,a,N,M] = eqtflength(b,a)
// Modifies the input vectors to give output vectors of the same length.
//
// Syntax
//   [b, a] = eqtflength(b, a)
//   [b, a, N, M] = eqtflength(b, a)
//
// Parameters
// b: Vector. The numerator coefficients of the transfer function.
// a: Vector. The denominator coefficients of the transfer function.
// N: Integer. The length of the numerator vector after modification.
// M: Integer. The length of the denominator vector after modification.
//
// Description
// This function modifies the input vectors `b` and `a` to ensure they have the same length by appending zeros to the shorter vector. 
// It also returns the lengths of the modified numerator and denominator vectors.
//
// Examples
// // Equalize lengths of numerator and denominator:
//    b = [1, 2]
//    a = [1, 2, 3]
//    [b, a] = eqtflength(b, a)
// // Return lengths of modified vectors:
//    b = [1, 2]
//    a = [1, 2, 3]
//    [b, a, N, M] = eqtflength(b, a)
//
// Authors
//  Debdeep Dey 


    if(argn(2)~=2)
        error('Incorrect number of input arguments');
    elseif(length(a)==0|max(abs(a))==0)
        error('Division by zero not allowed');
    elseif(type(b)==10 | type(a)==10)
        b=b;
        a=a;
    else
        a=a(:).';
        b=b(:).';
        a=[a,zeros(1,max(0,length(b)-length(a)))];
        b=[b,zeros(1,max(0,length(a)-length(b)))];
        ai=find(a~=0);
        bi=find(b~=0);
        M=ai($)-1;
        if isempty(bi) then
            N=0;
        else 
            N=bi($)-1;
        end
        n=max(M+1,N+1);
        a=a(1:n);
        b=b(1:n);
    end
endfunction

