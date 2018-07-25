// Returns input data in bit-reversed order

// Calling Sequence
//[y,i] = bitrevorder(x)
//y = bitrevorder(x)

// Parameters
//x: Vector of real or complex values
//y: input vector in bit reverse order
//i: indices

// Description
//This function returns the input data after reversing the bits of the indices and reordering the elements of the input array.

// Examples
//x = [%i,1,3,6*%i] ;
//[y i]=bitrevorder(x)
//Output :
// i  =
//
//    1.    3.    2.    4.
// y  =
//
//    i      3.    1.    6.i


//*************************************************************************************
//-------------------version1 (using callOctave / errored)-----------------------------
//*************************************************************************************

//function [y,i]=bitrevorder(x)
//funcprot(0);
//[lhs,rhs]=argn(0);
//if (rhs<1) then
//	error ("Wrong number of input arguments.")
//end
//[y,i]=callOctave("bitrevorder",x)
//
//endfunction

//*************************************************************************************
//-----------------------------version2 (pure scilab code)-----------------------------
//*************************************************************************************
function [y, i] = bitrevorder (x)

    funcprot(0);
    [nargout, nargin] = argn() ;

  if (nargin ~= 1)
    print_usage ();
  elseif (~ isvector (x))
    error ("bitrevorder: X must be a vector");
  elseif (fix (log2 (length (x))) ~= log2 (length (x)))
    error ("bitrevorder: X must have length equal to an integer power of 2");
  end

  [y, i] = digitrevorder (x, 2);

endfunction
