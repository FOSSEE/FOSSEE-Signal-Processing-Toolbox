// ...................................................Using"callOctave" method...................................................................................

//function w = tukeywin (m, r)
//This function returns the filter coefficients of a Tukey window.
//Calling Sequence
//w = tukeywin (m)
//w = tukeywin (m, r)
//Parameters
//m: positive integer
//r: positive real number, between 0 and 1
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Tukey window of length m supplied as input, to the output vector w.
//The second parameter r defines the ratio between the constant and cosine section and its value has to be between 0 and 1, with default value 0.5.
//Examples
//tukeywin(5, 2)
//ans  =
//    0.
//    0.5
//    1.
//    0.5
//    0.

//funcprot(0);
//rhs = argn(2)
//if(rhs<1 | rhs>2)
//error("Wrong number of input arguments.")
//end
//	select(rhs)
//	case 1 then
//	w = callOctave("tukeywin",m)
//	case 2 then
//	w = callOctave("tukeywin",m,r)
//	end
//endfunction




//...................................................................................................................................................................................
// .....................................................Using pure "Scilab".............................................................................................
//...................................................................................................................................................................................



function w = tukeywin (m, varargin)

 funcprot(0);
    [nargout,nargin]=argn();


  if (nargin < 1 | nargin > 2)
    error("Wrong Number of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("tukeywin: M must be a positive integer");
  elseif (nargin == 2)
    // check that 0 < r < 1
    r=varargin(1);
    if r > 1
      r = 1;
    elseif r < 0
      r = 0;
    end
  else
      r=0.5;
  end

      //generate window
  select(r)
    case 0,
      //full box
      w = ones (m, 1);
    case 1,
     // Hanning window
      w = hanning (m);
    else
      // cosine-tapered window
      t = linspace(0,1,m);
      t = t(1:$/2)';
      w = (1 + cos(%pi*(2*t/r-1)))/2;
      w(floor(r*(m-1)/2)+2:$) = 1;
      w = [w; ones(modulo(m,2)); w($:-1:1,:)];
  end

endfunction
