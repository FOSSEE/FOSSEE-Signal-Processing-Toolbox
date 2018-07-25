function [rmsx, w] =  movingrms(x, width, risetime, varargin)

// Find moving RMS value of signal in x

// Calling Sequence
//[rmsx,w]=movingrms(x,width,risetime)
//[rmsx,w]=movingrms(x,width,risetime,Fs)

// Parameters
//	x: (Real or complex valued vector or matrix) Input Signal
//	width: Real or complex scalar value
//	risetime: Real or complex scalar value
//	Fs: (Real or complex scalar value) Sampling frequency

// Description
//	In this function signal is convoluted against a sigmoid window of width w and risetime rc with the units of these parameters relative to the value of the sampling frequency given in Fs (Default value=1).

// Example : 1
//[a,b]=movingrms ([4.4 94 1;-2 5*%i 5],1,-2)
// Output:
// b  =
//
//    0.1887703
//    0.1887703
// a  =
//
//    0.9123683    17.719291    0.9625436
//    0.9123683    17.719291    0.9625436

//Example : 2
// [a,b]=movingrms ([4.4 94 1;-2 5*%i 5],1,-2,2)
//Output :
// b  =
//
//    1.
//    1.
// a  =
//
//    4.8332184    93.866927    5.0990195
//    4.8332184    93.866927    5.0990195

funcprot(0);

//**************************************************************************************************
//______________________________________________version1 code (not working)_________________________
//__________________________________________________________________________________________________
//**************************************************************************************************

//rhs=argn(2);
//if (rhs<3) then
//	error("Wrong number of input arguments.")
//elseif (rhs==3) then Fs=1;
//end
//[rmsx,w]=callOctave("movingrms",x,w,rc,Fs)

//**************************************************************************************************
//______________________________________________version2 code ( working)____________________________
//__________________________________________________________________________________________________
//**************************************************************************************************
if  argn(2) > 4 | argn(2) < 3 then
    error("movingrms : wrong number of inputs ")
end

    if length(varargin)==0 then
        Fs = 1;
    else
        Fs = varargin(1);
    end

  [N nc] = size (x);
  if width*Fs > N/2
    idx = [1 N];
    w    = ones(N,1);
  else
    idx   = round ((N + width*Fs*[-1 1])/2);
    w     = sigmoid_train((1:N)', idx, risetime*Fs);
  end
  fw    = fft (w.^2);
  //fx    = fft (x.^2); itdoes columwise fft in Octave but in scilab it does 2D fft

  //Evaluating columnwise fft using for loop
     fx = [];
  for k = 1:nc
      fx = [fx fft(x(:,k).^2)];
      k = k + 1;
  end
 //end of Evaluating columnwise fft using for loop

 // in octave fx.*fw  does row element wise multiplication but it is inconsistance in scilab
 //doing it using for loop
 fxw = [];
 for k = 1:N
     fxw = [fxw ; fx(k,:).*fw(k,:)]
 end
 //end of fxw computation

  //rmsx  = real(ifft (fxw)/(N-1)); itdoes columwise ifft in Octave but in scilab it does 2D ifft
    //Evaluating columnwise ifft using for loop
     ifxw = [];
  for k = 1:nc
      ifxw = [ifxw ifft(fxw(:,k))];
      k = k + 1;
  end

  rmsx  = real(ifxw/(N-1))
 //end of Evaluating columnwise ifft using for loop

  rmsx (rmsx < %eps*max(rmsx(:))) = 0;

  rmsx  = circshift (sqrt (rmsx), round(mean(idx)));
  //##w     = circshift (w, -idx(1));

endfunction
