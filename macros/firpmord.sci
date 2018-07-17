function [n, fo, ao, w] = firpmord(f, a, dev, varargin)
// Parks-McClennan optimal FIR filter order estimation
//
//
// Calling sequence
// [n,fo,ao,w] = firpmord(f,a,dev)
// [n,fo,ao,w] = firpmord(f,a,dev,fs)
//
// 
// Parameters
// f: double - positive - vector
//      Frequency band edges (between 0 and Fs/2).
//      Length of f is two less than the length of a.
// a: double - positive - vector
//      Desired amplitudes at the frequency bands specified by f.
// dev: double - positive - vector
//      Maximum allowable deviations.
//      Maximum acceptable deviations or ripples between the frequency response
//      and the desired amplitudes in the frequency bands specified by f. Must have 
//      the same length as a.
// n: int - scalar
//      Filter order
// fo: double - positive - vector
//      Frequency vector
// ao: double - positive - vector
//      Amplitude vector
// w: double - vector
//      Weights
//
// 
// Examples
// [1] A low-pass filter
//          f = [1500 2000];        // frequency edges for bands
//          a = [1 0];              // desired amplitude for each band
//          dev = [0.01 0.1];       // Acceptable deviation for each band
//          fs = 8000;              // Sampling frequency
//          [n,fo,ao,w] = firpmord(f,a,dev,fs);
//
// [2] A bandstop filter
//          f = [1000 1800 2400 3000];
//          a = [1 0 0.5];
//          dev = [0.01 0.1 0.03];
//          fs = 8000;
//          [n,fo,ao,w] = firpmord(f,a,dev,fs);
//
//
// References
// [1] Rabiner, Lawrence R., and Bernard Gold. "Theory and application of 
//     digital signal processing." Englewood Cliffs, NJ, Prentice-Hall, Inc., 
//     1975. 777 p. 156-7 (1975).
// [2] Rabiner, Lawrence R., and Otto Herrmann. "The predictability of certain 
//     optimum finite-impulse-response digital filters." Circuit Theory, 
//     IEEE Transactions on 20.4 (1973): 401-408.
//
// Authors
// Ayush Baid
//
//
// See Also
// buttord | cheb1ord | cheb2ord | ellipord | firpm | kaiserord

    [numOutArgs,numInArgs] = argn(0);
    
    
    // ********************
    // Checking number of arguments
    // ********************
    
    if numInArgs~=3 & numInArgs~=4 then
        msg = "firpmord: Wrong number of input argument; 3-4 expected";
        error(77,msg);
    end
    
    if numOutArgs~=4 then
        msg = "firpmord: Wrong number of output argument; 4 expected";
        error(78,msg);
    end
    
    // ********************
    // Parsing input args
    // ********************

    // Parsing fs
    fs = 2; // default
    if length(varargin)==1 then
        fs = varargin(1);
        if length(fs)~=1 then
            msg = "firpmord: Wrong type for argument #4 (fs): Positive real scalar expected";
            error(53,msg);
        end
        if fs<=0 then
            msg = "firpmord: Wrong type for argument #4 (fs): Positive real scalar expected";
            error(53,msg);
        end 
        if type(fs)~=1 & type(fs)~=8 then
            msg = "firpmord: Wrong type for argument #4 (fs): Positive real scalar expected";
            error(53,msg);
        end
    end
    
    // Checks on f
    if ~isvector(f) | (type(f)~=1 & type(f)~=8) then
        msg = "firpmord: Wrong type for argument #1 (f): Vector of positive reals expected";
        error(53,msg);
    end
    
    if ~(and(f>=0) & and(f<=fs/2)) then
        msg = "firpmord: Wrong value for argument #1 (f): Values must be between 0 and fs/2";
        error(116,msg);
    end
    
    
    // Check on a
    if ~isvector(a) | (type(a)~=1 & type(a)~=8) then
        msg = "firpmord: Wrong type for argument #2 (a): Vector of positive reals expected";
        error(53,msg);
    end
    if ~and(a>=0) then
        msg = "firpmord: Wrong value for argument #2 (a): Values must be positive";
        error(116,msg);
    end
    
    if length(f)~=2*length(a)-2 then
        msg = "firpmord: Wrong type for arguments #1(f) and #2 (a): Length of f must be two less than twice the length of a ";
        error(53,msg);
    end
    
    
    // Check on dev
    if ~isvector(dev) | (type(dev)~=1 & type(dev)~=8) then
        msg = "firpmord: Wrong type for argument #3 (dev): Vector of positive reals expected";
        error(53,msg);
    end
    if ~and(dev>0) then
        msg = "firpmord: Wrong value for argument #3 (dev): Values must be positive";
        error(116,msg);
    end
    if length(dev)~=length(a) then
        msg = "firpmord: Wrong type for arguments #2(a) and #3 (dev): Length of a and dev must be equal";
        error(53,msg);
    end
    
    // ********************
    // Some preprocessing
    // ********************
    
    // Turn every vector into a column vector
    f = f(:);
    a = a(:);
    dev = dev(:);
    
    // Normalizing frequencies
    f = f./fs;
    
    // Get deviation relative to the amplutudes
    is_zero = a==0; 
    dev = dev./(is_zero+a); // no scaling req. when desired amplitude is 0
    
    
    num_bands = size(a,1);
    
    // Dividing frequency band edges into 2 vectors, f1 and f2, denoting 
    // passband and stopband edges respectively.
    f1 = f(1:2:$-1);
    f2 = f(2:2:$);
    
    
    // ********************'
    // Calculations for filter order
    // ********************
    
    // Note: Amplitudes don't matter for order as they can be adjusted by 
    //       scaling and linear shifting    
    
    if num_bands==2 then
        // Simple low-pass or high-pass filter, use single_transition_order_estimation
        
        L = single_trans_order_est(f1(1), f2(1), dev(1), dev(2));
    else
        // We have a bandpass filter, which will be considered to be composed
        // of a cascade of simple high-pass/low-pass filters
        
        // The first filter is considered high-pass (if it is low pass in reality,
        // the filter just has to be negated; filter order does not change)
        
        // Loop over different simple filters and select the highest required length
        L = 0
        for i=2:num_bands-1
            L1 = single_trans_order_est(f1(i-1), f2(i-1), dev(i), dev(i-1));
            L2 = single_trans_order_est(f1(i), f2(i), dev(i), dev(i+1));
            L = max([L; L1; L2]);
        end
    end
    
    // filt. order = L-1
    n = ceil(L) - 1;
    
    // frequency and respective amplitudes
    fo = [0;2*f;1];
    ao = zeros(size(fo,1),1);
    ao(1:2:$) = a;
    ao(2:2:$) = a;
    
    // weights
    w = ones(size(dev,1),1)*max(dev)./dev;            
    
endfunction

function L = single_trans_order_est(freq1, freq2, delta1, delta2)
// Calculates the filter order for a single transition band filter ( simple 
// low-pass or simple high-pass filter)
//
//
// Parameters (assuming a low-pass filter; notations change for high pass filter)
//      freq1: passband cutoff frequency (normalized)
//      freq2: stopband cutoff frequency (normalized)
//      delta1: passband ripple (max. allowed)
//      delta2: stopband attenuation (not in dB)
//      L: filter length; filter order = L-1
//
// Note: will not work well when transition near f = 0 or 0.5
//
// References
// [1] Rabiner, Lawrence R., and Bernard Gold. "Theory and application of 
//     digital signal processing." Englewood Cliffs, NJ, Prentice-Hall, Inc., 
//     1975. 777 p. 156-7 (1975).

    // Creating a matrix for consice representation of coeffs a_i used in Eq. 3.142
    // and b_i in Eq. 3.143 in [1]
    A = [-4.278e-1, -4.761e-1; -5.941e-1, 7.114e-2; -2.66e-3, 5.309e-3];
    B = [11.01217, 0.51244];

    log_delta1 = log10(delta1);
    log_delta2 = log10(delta2);

    // Evaluating Eq. 3.142 (Ref. [1])
    D = [1, log_delta1, log_delta1.^2] * A * [1; log_delta2];

    // Evaluating Eq. 3.143 (Ref. [1])
    f = B * [1; log_delta1 - log_delta2];

    // Evaluating Eq. 3.145 (Ref. [1])
    del_freq = abs(freq1 - freq2);
    L = D./del_freq - f.*del_freq + 1;

endfunction 
