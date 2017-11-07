
function out = rssq(in, orientation)
//This function calculates the square root of the sum of values of input vector IN.
//
//Calling Sequence
//OUT=rssq(IN)
//OUT=rssq(IN,orientation)
//
//Parameters
//in:Vector or Matrix of real or complex elements.
//orientation: A string with possible values "r", "c" or "m" or numericals such as '1' or '2',giving the dimension along which the rssq value is to be calculated. 
//out:A scalar with real value when input is a vector.When input is a matrix, out is the root sum squared  value along the orientation specified or the default one when not specified.
//
//Description
//For vector as input, the output is real valued scalar containing the rssq value. The rssq value can be calculated by taking the square root of the squared sum of the elements.
//If the input IN is a matrix, the output of function is rssq value of each column stored in a row vector OUT.
//
//When the elements of IN are COMPLEX, the absolute value of the element is used to calculate the output.
//When the orientation is not specified for N dimensional array, it is taken as the index of the first dimension of IN that is greater than 1 and calculation is done along that orientation.
//
//When the orientation is specified the output is calculated along that dimension.
//The orientation can be specified as 1 for rssq value of columns of matrix IN or as r.
//For rssq value of rows of matrix orientation should be 2 or c.
//
//Examples
//To calculate rssq of a vector:
//IN=[2 4 6]
//OUT=rssq(IN)
//The output is 7.4833148
//
//Examples
//To calculate rssq of rows of matrix:
//IN=[1 3 5;2 4 6;7 8 9]
//OUT=rssq(IN,2)
//The output should be OUT=
    //5.9160798  
    //7.4833148  
    //13.928388
//
//Examples
//To calculate rssq of a columns of complex matrix:
//
//IN=[5+%i*3 2+%i*4; 3+%i*6 1+%i*2]
//OUT=rssq(IN,1)
//The output should be OUT= 8.8881944 5.
//See also
//abs 
//mean
//sqrt 
//isempty
//
//Authors
//Indira Askaukar
//
//Bibliography
//Matlab help document.


if argn(2)==1//when the orienatation is not specified
    a=abs(in)//This calculates the absolute value of complex numbers
    a=a.^2
    s=sum(a,"m")
    out=sqrt(s)
  
else
    a=abs(in)
    a=a.^2
    s=sum(a,orientation)
    out=sqrt(s)
  
end
endfunction
