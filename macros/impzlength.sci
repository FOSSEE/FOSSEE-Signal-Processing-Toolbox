
function len = impzlength (b, varargin)
// Impulse response length
// 
// Calling Sequence
// len = impzlength(b, a, tol)
// 		returns the impulse response length for the causal discrete-time filter 
//		with the transfer function coefficients for numerator and denominator in 
//		b and a respectively. For stable IIR filters, len is the effective length
//		impulse response length, i.e. the length after which the response is
//		essentially zero
// len = impzlength(sos)
//		returns the impulse response length of the filter specified by second 
//		order sections matrix. sos is a Kx6 matrix, where K is the number of 
//		sections. Each row of the sos matrix corresponds to a second order 
//		biquad filter
// len = impzlength(__, tol)
//		specifies a tolerance for estimating the effective impulse response 
//		length in case of an IIR filter. By default, tol is 5e-5. Increasing tol
//		leads to shorter len and vice-versa
//
// Parameters
// b - real|complex - vector|scalar
//		Numerator coefficients
// a - real|complex - vector|scalar
//		Denominator coefficients
// sos - real|complex - matrix (K-by-6)
//		Second order estimates
// tol - positive real - scalar
//		Tolerance for estimating the effective length of an IIR filter impulse
//		response
//
// Examples
// 1) Low pass IIR filter with pole at 0.9
// 		b = 1;
//		a = [1 -0.9];
//		len = impzlength(b,a)
//OUTPUT :
//                   len=93
// 
//2) High pass IIR filter with pole at -0.5
// 		b = 1;
//		a = [1 0.5];
//		len = impzlength(b,a)
//OUTPUT :
//                   len=14

// See also
// designfilt | digitalFilter | impz | zp2sos
//
// Authors
// Ayush Baid

[numOutArgs, numInArgs] = argn(0);

// *****
// Checking the number of arguments
// *****
if numInArgs<1 | numInArgs>3 then
 	msg = "impzlength: Wrong number of input argument; 1-3 expected";
    error(77,msg);
end
    
if numOutArgs~=1 then
    msg = "cummin: Wrong number of output argument; 1 expected";
    error(78,msg);
end

// *****
// Parsing input arguments
// *****
isSos = %f;
tol = 5e-5;
a = 1;

if size(b,2)==6 & size(b,1)>=2 then
	// input is sos
	isSos = %t;	
	if length(varargin)==1 then
		tol = varargin(1);
	elseif length(varargin)>1 then
		msg = "impzlength: Wrong number of input arguments; only one extra argument if 1st argument is sos";
		error(77,msg);
	end
else
	if length(varargin)==0 then
		msg = "impzlength: Wrong number of input arguments; atleast 2 required when input is transfer function coefficients";
		error(77,msg);		
	elseif length(varargin)==1 then
		a = varargin(1);
	else
		a = varargin(1);
		tol = varargin(2);
	end
end

// *****
// Check on argument types
// *****

// checking arguments

// ** b or sos
if ~isSos then
	if isempty(b) then
		b = 1;
	end
	if size(b,1)==1 & size(b,2)~=1 then
		b = b(:);
	elseif size(b,2)~=1 then
		// only scalar/vector accepted
		msg = "impzlength: Wrong size of input argument #1 (b); must be a vector"
		error(60,msg);
	end
end

if type(b)~=8 & type(b)~=1 then
	msg = "impzlength: Wrong type for argument #1 (b); Real or complex entries expected ";
    error(53,msg);
end

// ** a

if isempty(a) then
	a = 1;
end
if size(a,1)==1 & size(a,2)~=1 then
	a = a(:);
elseif size(a,2)~=1 then
	// only scalar/vector accepted
	msg = "impzlength: Wrong size of input argument #2 (a); must be a vector"
	error(60,msg);
end

if type(a)~=8 & type(a)~=1 then
	msg = "impzlength: Wrong type for argument #2 (a); Real or complex entries expected ";
    error(53,msg);
end

// ** tol
if (type(tol)~=8 & type(tol)~=1) | length(tol)~=1 | tol<=0 then
	if isSos then
		msg = "impzlength: Wrong type for argument #2 (tol); Positive scalar expected"
	else
		msg = "impzlength: Wrong type for argument #3 (tol); Positive scalar expected"
	end
	error(53,msg);
end


// *****
// Calculation
// *****

if isSos
	// calculating the length of all fir components and the max length of all 
	// iir components
	fir_len = 1;
	iir_len = 1;
	for i=1:size(b,1)
		num = b(i,1:3);
		den = b(i,4:6);

		if den(2)==0 & den(3)==0 then
			// fir section
			fir_len = fir_len + length(num) - 1;
		else
			iir_len = max(iir_len, impzlength_singlefilter(num,den,tol));
		end	
	end
	len = max(fir_len, iir_len);
else
	len = impzlength_singlefilter(b,a,tol);
end

endfunction
			
function len = impzlength_singlefilter (b, a, tol)
	// Adapted to scilab from octave's signal package (GNU GPL)

	if length(a) > 1 & sum(a(2:$))~=0 then
		// IIR filter
		precision = 1e-6;

    	r = roots(a);
    	pole_mag = abs(r);
    	maxpole = max(pole_mag);

    	// get the multiplicity of maxpole
        mult = get_multiplicity(r,maxpole);

    	if (maxpole > 1+precision) then     		// unstable -- cutoff at 120 dB
      		n = floor(6/log10(maxpole));
    	elseif (maxpole < 1-precision) then		//stable
      		n = floor(mult*log10(tol)/log10(maxpole));
	    else                           		// periodic -- cutoff after 5 cycles
      		n = 30;

      		unit_poles_idx = find(pole_mag>=1-precision);

      		r(unit_poles_idx) = -r(unit_poles_idx);

      		pole_phase = atan(imag(r),real(r));		


			// find longest period less than infinity
      		// cutoff after 5 cycles (w=10*pi)
      		periodic_idx = find(unit_poles_idx & abs(pole_phase)>0);
      		if ~isempty(periodic_idx) then
      			disp('periodic');
        		n = ceil(10*%pi./min(abs(pole_phase(periodic_idx))));
        		//if (n_periodic > n) then
          		//	n = n_periodic;
        		//end
      		end

    		// find most damped pole
    		// cutoff at -60 dB
    		damped_idx = find(pole_mag<1-precision); 
      		if ~isempty(damped_idx) then
        		n_damped = floor(log10(tol)/log10(max(pole_mag(damped_idx))));
        		if (n_damped > n) then
          			n = n_damped;
        		end
      		end
		end

    	// n = n + length(b) - 1;
    	len = max(length(a)+length(b)-1,floor(n));

	else
	    len = length(b);
  	end

  	

endfunction

function mult = get_multiplicity(poles,query_mag)
	// returns the number of the poles with the given magnitude
	// Complex conjugate pairs are counted as 1

	mags = abs(poles);
	conj_poles = conj(poles);

	// get indices of poles with matching magnitude
	idx = mags>query_mag-1e-3 & mags<query_mag+1e-3;

	mult = 0;
	// select only one pole from each complex conjugate pairs
	for i=1:length(idx)
		if idx(i) then
			mult = mult+1;
			for j=i+1:length(idx)
				if poles(i)==conj_poles(j) then
					idx(j) = %f;
				end
			end
		end
	end
endfunction
