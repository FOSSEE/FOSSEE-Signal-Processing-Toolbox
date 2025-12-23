
function [ydb] = mag2db(y)
// Convert magnitude to decibels.
//
// Syntax
//   ydb = mag2db(y)
//
// Parameters
// y: Input magnitude values (vector or matrix).
//
// Description
// The `mag2db` function converts magnitude measurements specified in `y` to decibels (dB) 
// using the formula: ydb = 20 * log10(y).
//
// - If `y` contains negative real values, the corresponding `ydb` values are set to NaN.
// - If `y` contains zeros, the corresponding `ydb` values are set to -Inf.
//
// Examples
// y = [1, 10, 0.1, 0, -5]
// ydb = mag2db(y)
// 
// Authors
// Debdeep Dey

    funcprot(0);

    ydb(find(abs(y)>0))= 20 * log10(y(find(abs(y)>0)));
    ydb(find(real(y)<0))=%nan;
    ydb(find(y==0))=-%inf;
    ydb=matrix(ydb,size(y));
        

endfunction

