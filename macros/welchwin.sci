function w = welchwin (m, opt)
//This function returns the filter coefficients of a Welch window.
//Calling Sequence
//w = welchwin (m)
//w = welchwin (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Welch window of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//For symmetric, the length should be an integer>2. For periodic, the length should be an integer>1.
//Examples
//welchwin(4,"symmetric")
//ans  =
//    0.         
//    0.8888889  
//    0.8888889  
//    0.         
 


rhs = argn(2)
if(argn(2)<1 | argn(2)>2)
error("Wrong number of input arguments.")
end

 if ((~isscalar (m) & (m == fix (m)) & (m > 0))) then
    error (" M must be a positive integer");
  end


  N = (m - 1) / 2;
  mmin = 3;
if argn(2)==2 then
       
    select (opt)
      case "periodic"
        N = m / 2;
        mmin = 2;
      case "symmetric"
        N = (m - 1) / 2;
      else
        error ("window type must be either periodic or symmetric");
    end
  end
  

  if (m < mmin)
    error ('M must be an integer greater than mmin');
  end

  n = [0:m-1]';
  w = 1 - ((n-N)./N).^2;

endfunction
