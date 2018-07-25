function w = kaiser (m, varargin)
//This function returns the filter coefficients of a Kaiser window.

//Calling Sequence
//w = kaiser (m)
//w = kaiser (m, beta)

//Parameters
//m: positive integer value
//beta: real scalar value
//w: output variable, vector of real numbers

//Description
//This is an Octave function.
//This function returns the filter coefficients of a Kaiser window of length m supplied as input, to the output vector w.
//The second parameter gives the stop band attenuation of the Fourier transform of the window on derivation.

//Examples
//kaiser(6,0.2)
// ans  =
//
//    0.9900745
//    0.9964211
//    0.9996020
//    0.9996020
//    0.9964211
//    0.9900745

funcprot(0);
    rhs = argn(2)
    if(rhs<1 | rhs>2)
    error("Wrong number of input arguments.")
    end

    if length(varargin)==0 then
        bet = 0.5; //default value of beta is 0.5
    else
        bet = varargin(1);
    end

w = window('kr', m, bet) //default value of beta is 0.5
w = w' ;

endfunction
