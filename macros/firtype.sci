function typ=firtype(b)
// Identify the type of a linear phase FIR filter.
//
// Syntax
//   t = firtype(b)
//
// Parameters
// b: Vector. The filter coefficients.
// t: Integer. The type of the FIR filter. Can be 1, 2, 3, or 4.
//
// Description
// This function determines the type, `t`, of a linear phase FIR filter with coefficients `b`. The filter must be real and have linear phase.
// The type is determined as follows:
// - Type 1: Symmetrical coefficients with an odd length.
// - Type 2: Symmetrical coefficients with an even length.
// - Type 3: Anti-symmetrical coefficients with an odd length.
// - Type 4: Anti-symmetrical coefficients with an even length.
//
// If the filter does not have linear phase, the function returns `t = -1`.
//
// Examples
// // Symmetrical filter with even length:
//    b = [9.2762e-05, 9.5482e-02, 4.0443e-01, 4.0443e-01, 9.5482e-02, 9.2762e-05]
//    t = firtype(b)
//
// // Anti-symmetrical filter with odd length:
//    b = [-1, -2, 0, 2, 1]
//    t = firtype(b)
//   
// Authors
//  Parthasarathi Panda 
//

    if (type(b)~=1) then
        error('check input type');
    end
    v=size(b);
    if length(v)>2 then
        error('check input dimension');
    end
    if v(1)~=1 & v(2)~=1 then
        error('check input dimension');
    elseif v(2)==1
        b=b';
    end
    m=length(b);
    sym=(b-b($:-1:1))*(b-b($:-1:1))';//zero if symmetrical
    antisym=(b+b($:-1:1))*(b+b($:-1:1))';//zero if antisymmetrical
    if (sym==0) then
        if (pmodulo(m,2)==1) then
            typ=1;
        else
            typ=2;
        end
    elseif (antisym==0)
        if (pmodulo(m,2)==1) then
            typ=3;
        else
            typ=4;
        end
    else
        typ=-1;//not linear phas
    end
endfunction
