function [is_AKICc] = check(str)
// Check if the input string is equal to "AKICc".
//
// Syntax
//   s = check(str)
//
// Parameters
// str: String. Input string to be checked.
// s: Boolean. Returns `T` (True) if the input string is "AKICc", otherwise `F` (False).
//
// Description
// This function checks whether the input string is equal to "AKICc". If it is, the function returns `T` (True); otherwise, it returns `F` (False).
//
// Examples
// check("apple")
// 

funcprot(0);
is_AKICc = (str == "AKICc")
endfunction
