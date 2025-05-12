function [y] = db2pow(ydb)
// Convert decibel values to power values in Watts.
//
// Syntax
//   y = db2pow(ydb)
//
// Parameters
// ydb: Scalar, vector, matrix, or N-D array. Represents the input decibel values.
//
// y: Scalar, vector, matrix, or N-D array. Represents the output power values in Watts.
//
// Description
// This function calculates the power value in Watts corresponding to the decibel value `ydb` passed as the parameter. 
// The conversion is based on the formula: ydb = 10 * log10(y), where `log10` is the base-10 logarithm.
//
// Examples
// ydb = 20;
// y = db2pow(ydb)
//
// Authors
//  Ishita Bedi
//  Debdeep Dey
// 

//  Modified to handle character input by Debdeep Dey
//


funcprot(0);
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end
//This statement calculates the power in Watt of ydb which was in decibel using ydb = 10log (y) -- log base 10
if(type(ydb)~=10) then
    y = 10.^(ydb/10); 
else
    y1=ascii(y);
    y = 10.^(y1/10);
end

endfunction 

