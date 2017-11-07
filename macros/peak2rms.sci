function out = peak2rms(in,orientation)
//This function calculates the ratio of peak magnitude to the Root Mean Square(RMS) value.
//
//Calling Sequence
//OUT=peak2rms(IN)
//OUT=peak2rms(IN,orientation)
//
//Parameters
//in:Vector or Matrix of real or complex elements.
//orientation: A string with possible values "r", "c" or "m" giving the dimension along which the peak2rms value is to be calculated. 
//out:A scalar with real value when input is a vector.When input is a matrix, out is the peak magnitude to RMS  value along the orientation specified or the default one when not specified.
//
//Description
//For vector as input, the output is the ratio of peak value to the RMS value. The RMS value can be calculated by taking the square root of mean value of the squared sum of the elements.
//
//When a matrix is given as input the output is peak to RMS ratio in the orientation specified.
//The orientation can be given as  string with values "r","c" or "m".
//
//peak2rms(in, 1) calculates the values of ratio of peak to RMS  of columns of matrix. The output in this case is a row vector with peak2rms value of each column of in.
//
//peak2rms(in, 2) calculates the  values of ratio of peak to RMS of rows of   matrix, where the output would be a column vector having peak2rms value of each row of in.
//
//The default orientation is chosen to be the index of first dimension of input greater than 1.Hence peak2rms(in) is equivalent to peak2rms(in, "m").
//
//For an N dimensional array the orientation is the index of first non singleton dimension of the array.
//
//If the elements of matrix are complex the absolute values are considered in the calculation of RMS value.
//
//Examples
//To calculate peak2rms of a vector:
//IN=[6 19 10 25]
//OUT=peak2rms(IN)
//The output is OUT=
    // 1.4638501  
    //1.3887301  
    //1.119186 
//
//Examples
//To calculate peak2rms of rows of matrix:
//IN=[1 3 5;2 4 6;7 8 9]
//OUT=peak2rms(IN,2)
//The output is
   //OUT= 1.3719887
//
//Examples
//To calculate peak magnitude to RMS value of sinusoid:
//
//t=0:0.6:9
//IN=cos(6*%pi*t);
//OUT= peak2rms(IN)
//The output is
   //OUT= 1.3719887
//See also
//abs 
//mean
// max 
//sqrt 
//isempty
//
//Authors
//Indira Askaukar
//
//Bibliography
//Matlab help document.
//Modified to accept char i/p 
//MOdified function to match MATLAB input arguments
//Now for calculating the values of ratio of peak to RMS  of columns of matrix use peak2rms(in,1)
//And for calculates the values of ratio of peak to RMS  of rows of matrix.  use peak2rms(in,2)
//Updated help comments accordingly
//MOdifications done by by Debdeep Dey
    if(type(in)=10) then //if i/p is of type char convert it to its ascii value
        in=ascii(in);
    end
     
    if argn(2)==1
        //calculating the Root Mean Square value
    a=abs(in)
    a=a.^2
    s=mean(a,"m")
    rmsvalue=sqrt(s)
    peak = max(abs(in),"m")
    rmsq = rmsvalue
  
else
    //Calculation of the RMS value
    if orientation==1 then
        orient='r';
    else
        orient='c';
    end
    
    a=abs(in)
    a=a.^2
    s=mean(a,orient)
    rmsvalue=sqrt(s)
   [peak,k] = max(abs(in),orient)
    rmsq = rmsvalue
  
end
    //Calculation of Ratio of peak to the Root Mean square value
if isempty(peak)
  out = rmsq;
else
  out = peak ./ rmsq;
end
endfunction
