function [s] = check(str)
//It checks whether the input string is equal to "AKICc". If it is equal, then it results T(True) else it returns F(False)
//s: output variable
//str: Input string
//Example:
//check("apple")
//output:
//F
funcprot(0);
is_AKICc = (str == "AKICc")  
disp(is_AKICc)
endfunction
