function  [y, h] = resample( x, p, q, h )
//This function resamples in the input sequence x supplied by a factor of p/q.

//Calling Sequence
//y = resample(x, p, q)
//y = resample(x, p, q, h)
//[y, h] = resample(...)

//Parameters
//x: scalar, vector or matrix of real or complex numbers
//p: positive integer value
//q: positive integer value
//h: scalar, vector or matrix of real or complex numbers

//Description
//This is an Octave function.
//This function resamples in the input sequence x supplied by a factor of p/q. If x is a matrix, then every column is resampled.hange the sample rate of x by a factor of p/q.
//This is performed using a polyphase algorithm. The impulse response h, given as parameter 4, of the antialiasing filter is either specified or designed with a Kaiser-windowed sinecard.

//Examples
//resample(1,2,3)
//ans =  0.66667

funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(rhs<3 | rhs>4)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 3 then
	if(lhs==1)
	y = callOctave("resample",x,p,q)
	elseif(lhs==2)
	[y,h] = callOctave("resample",x,p,q)
	end
	case 4 then
	if(lhs==1)
	y = callOctave("resample",x,p,q,h)
	elseif(lhs==2)
	[y,h] = callOctave("resample",x,p,q,h)
	end
	end
endfunction


//**************************************************************************************************
//Tried to impement without callOctave but fot this it requires ufirdn function which implemented in .cc file in octave, simple implementation of upfirdn doesn't work for resample function
//**************************************************************************************************



//function  [y, h] = resample( x, p, q, h )
//  nargin = argn(2);
//
//  [rows, columns] = size(x) ;
//
//  if nargin < 3 | nargin > 4
//    error("resample.sci : invalid number of inputs");
//  elseif or([p q]<=0) | or([p q]~=floor([p q])),
//    error("resample.sci: p and q must be positive integers");
//  end
//
////  ## simplify decimation and interpolation factors
//
//  great_common_divisor=gcd([p,q]);
//  if (great_common_divisor>1)
//    p = double(p) / double (great_common_divisor);
//    q = double(q) / double (great_common_divisor);
//  else
//    p = double(p);
//    q = double(q);
//  end
//
////  ## filter design if required
//
//  if (nargin < 4)
//
////    ## properties of the antialiasing filter
//
//    log10_rejection = -3.0;
//    stopband_cutoff_f = 1 / (2 * max (p, q));
//    roll_off_width = stopband_cutoff_f / 10.0;
//
////    ## determine filter length
////    ## use empirical formula from [2] Chap 7, Eq. (7.63) p 476
//
//    rejection_dB = -20.0*log10_rejection;
//    L = ceil((rejection_dB-8.0) / (28.714 * roll_off_width));
//
////    ## ideal sinc filter
//
//    t=(-L:L)';
//    ideal_filter=2*p*stopband_cutoff_f*sinc(2*stopband_cutoff_f*t);
//
////    ## determine parameter of Kaiser window
////    ## use empirical formula from [2] Chap 7, Eq. (7.62) p 474
//
//    if ((rejection_dB>=21) & (rejection_dB<=50))
//      beta = 0.5842 * (rejection_dB-21.0)^0.4 + 0.07886 * (rejection_dB-21.0);
//    elseif (rejection_dB>50)
//      beta = 0.1102 * (rejection_dB-8.7);
//    else
//      beta = 0.0;
//    end
//
////    ## apodize ideal filter response
//
//    h=kaiser(2*L+1,beta).*ideal_filter;
//
//  end
//
////  ## check if input is a row vector
//  isrowvector=%F;
//  if ((rows==1) & (columns>1))
//    x=x(:);
//    isrowvector=%T;
//  end
//
////  ## check if filter is a vector
//  if ~isvector(h)
//    error("resample.sci: the filter h should be a vector");
//  end
//
//  Lx = rows;
//  Lh = length(h);
//  L = ( Lh - 1 )/2.0;
//  Ly = ceil(Lx*p/q);
//
////  ## pre and postpad filter response
//
//  nz_pre = floor(q-pmodulo(L,q));
////  hpad = prepad(h,Lh+nz_pre);
//  hpad = h ;
//  for i = 1:Lh+nz_pre-length(h)
//      hpad = [0;hpad];
//  end
//
//  offset = floor((L+nz_pre)/q);
//  nz_post = 0;
//  while ceil( ( (Lx-1)*p + nz_pre + Lh + nz_post )/q ) - offset < Ly
//    nz_post = nz_post + 1;
//  end
//
//  //hpad = postpad(hpad,Lh + nz_pre + nz_post);
//  for i = 1:Lh + nz_pre + nz_post-length(hpad)
//      hpad = [hpad;0];
//  end
//
////  ## filtering
//  xfilt = upfirdn(x,hpad,p,q);
//  y = xfilt(offset+1:offset+Ly,:);
//
//  if isrowvector,
//    y=y.';
//  end
//
//endfunctio
