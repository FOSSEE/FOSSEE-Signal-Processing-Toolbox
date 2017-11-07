function [y] = db2pow(ydb)

//This function calculates the power value in Watt of the decibel value ydb passed as the parameter 
//Calling sequence
//function [y] = mag2pow(ydb)
//Parameters
//ydb : scalar or vector or matrix or N-D array
//Examples
//ydb = 20
//y=mag2pow(ydb)
//Authors
//Ishita Bedi
//Modified to handle char i/p by Debdeep Dey

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

