// Returns input data in digit-reversed order

// Calling Sequence
//[y,i] = digitrevorder(x,r)
//y = digitrevorder(x,r)

// Parameters
//x: Vector of real or complex values
//r: radix / base
//y: input vector in digit reverse order
//i: indices

// Description
//This function returns the input data after reversing the digits of the indices and reordering the elements of the input array.

// Examples
//x = [%i,1,3,6*%i] ;
//r = 2 ;
//[y i]=digitrevorder(x, r)
//Output :
// i  =
//
//    1.    3.    2.    4.
// y  =
//
//    i      3.    1.    6.i
function [y, i] = digitrevorder (x, r)
    funcprot(0);
    [nargout, nargin] = argn() ;

  if (nargin > 2 | nargin <= 1)
    error("digitrevorder : invalid number of inputs")
  elseif (~ isvector (x))
    error ("digitrevorder : X must be a vector");
  elseif (~ (isscalar (r) & r == fix (r) & r >= 2 & r <= 36))
    error ("digitrevorder : R must be an integer between 2 and 36");
  else
    tmp = log (length(x)) / log (r);
    if (fix (tmp) ~= tmp)
      error ("digitrevorder: X must have length equal to an integer power of radix");
    end
  end

  old_ind = 0:length(x) - 1;

  //new_ind = base2dec(mtlb_fliplr(dec2base(old_ind, r)), r); //it works only on octave
  old_ind_base = dec2base(old_ind, r) ;
  new_ind_base = [] ;
  b = [] ;
  for i=1:length(x)
      new_ind_base = [new_ind_base mtlb_fliplr(old_ind_base(i))];
  end
  new_ind = base2dec(new_ind_base,r) ;
  //end of index conversion

  i = new_ind + 1;
  y(old_ind + 1) = x(i);

  [rows_x columns_x] = size(x) ;

  if (columns_x == 1)
    y = y';
  else
    i = i;
  end

endfunction
