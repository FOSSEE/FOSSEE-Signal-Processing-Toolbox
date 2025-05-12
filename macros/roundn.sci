function r=roundn(x,n)
// Round a number to a specified number of decimal places.
//
// Syntax
//   r = roundn(x, n)
//
// Parameters
// x: Input number or array.
// n: Number of decimal places to round to.
//
// Outputs
// r: Rounded number or array.
//
// Description
// The `roundn` function rounds the input `x` to `n` decimal places.
//
// Example
// 1. Round a number to 2 decimal places:
//    r = roundn(3.14159, 2);
//    // Output: r = 3.14

    r=(round(x*10^n))/(10^n);
endfunction
