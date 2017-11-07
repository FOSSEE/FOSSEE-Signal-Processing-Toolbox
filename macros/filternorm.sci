function L = filternorm(b,a,varargin)
// Calculates the L-2 norm or L-infinity norm of a digital filter
//
// Calling Sequence
// L = filternorm(b,a)
// L = filternorm(b,a,pnorm)
// L = filternorm(b,a,2,tol)
//
//
// Parameters
// b: The filter numerator coefficients.
// a: The filter denominator coefficients.
// pnorm: The L-norm to be calculated. The values accepted are 2 (L2 norm) or %inf (L-infinity norm). Default value is 2.
// tol: The tolerance of the L-2 norm to be calculated. If tol not specified, it defaults to 10^(-8). tol must be a positive scalar
//
//
// Examples
// // 1) L-2 norm of an IIR filter with tol = 10^(-10)
//      b = [-3 2];
//      a = [1 -0.5];
//      L = filternorm(b, a, 2, 10d-10);
//
//
// See also
// norm
// zp2sos
//
// Authors
// Ayush Baid

exec('impz.sci', -1);

// ** Check on number of input, output arguments
[numOutArgs, numInArgs] = argn(0);

if numInArgs<2 | numInArgs>4 then
    msg = "filternorm: Wrong number of input argument; 2-4 expected";
    error(77,msg);
end

if numOutArgs~=1 then
    msg = "filternorm: Wrong number of output argument; 1 expected";
    error(78,msg);
end

// ** Check on b and a **
if isempty(a) then
    a = 1;
end
if isempty(b) then
    b = 1;
end

b = b(:);
a = a(:);

// check on datatype
if type(b)~=1 & type(b)~=8 then
    msg = "filternorm: Wrong type for argument #1 (b): Real or complex matrix expected";
    error(53,msg);
end
if type(a)~=1 & type(a)~=8 then
    msg = "filternorm: Wrong type for argument #2 (a): Real or complex matrix expected";
    error(53,msg);
end

// check on dimensions
if size(b,1)==1 then
    b = b(:);
end
if size(a,1)==1 then
    a = a(:);
end

if size(b,2)~=size(a,2) then
    msg = "filternorm: Wrong size for arguments #1 (b) and #2(a): Same number of columns expected";
    error(60,msg);
end

// ** Parsing the remaining arguments **
if length(varargin)==1 & ~isempty(varargin) then
    pnorm = varargin(1);
    tol = 1e-8;
elseif length(varargin)==2 then
    pnorm = varargin(1);
    tol = varargin(2);
    if tol<=0 | length(tol)~=1 then
        msg = "filternorm: Wrong value for argument #4 (tol): Must be a positive real scalar";
        error(116,msg);
    end
else
    pnorm = 2;
    tol = 1e-8;
end

if pnorm~=2 & length(varargin)==2 then
    msg = "filternorm: Warning - Wrong value for argument #3 (pnorm): Must be 2 when tolerance is used";
end

// ** Calculations **

if isinf(pnorm) then
    // We need to compute the frequency response and then get the one
    // with the highest magnitude
    h = frmag(b, a, 1024);
    L = max(h);
else
    if size(a,1) == 1 then
        // the filter is FIR; impluse response is the filter coeffs
        L = norm(b,pnorm)/a;
    else
        // the filter is IIR
        // Checking for stability, as we wont be able to calc impulse response
        // within a given tolerance.
        
        pole_mag = abs(roots(a));
        
        // stability check
        max_dist = max(pole_mag);
        if max_dist>=1 then
            // poles lie on the unit circle or outside it. We do not have a 
            // decaying impulse response and hence truncation is not advisable
            msg = "filternorm: Non convergent impulse response. All poles should lie inside the unit circle";
            error(msg);
        end
        
        // ****
        // Theory: (assuming stable filter)
        // Each pole will contribute a decaying exponential. The pole with
        // the highest magnitude will decay the slowest (i.e. will be the most
        // dominant). Therefore, we will work with pole(s) having the largest
        // magnitude to obtain a bound on the L2 norm of the tail.
        // ****
        
        // get the multiplicity of the largest pole
        mult = sum(pole_mag>(max_dist-1e-5) & pole_mag<(max_dist+1e-5));

        // Using integration of a^(-x) to get a bound            
        N = mult*log(tol)/log(max_dist);

        // TODO: get filter coeffs using impzlength from octave
        [h, temp1] = impz(b,a);
        L = norm(h,2);
    end
end

endfunction
