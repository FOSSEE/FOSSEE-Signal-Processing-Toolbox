function [psi,x]=shanwavf(lb,ub,n,fb,fc)
// Compute the Complex Shannon wavelet.
//
// Syntax
//   [psi, x] = shanwavf(lb, ub, n, fb, fc)
//
// Parameters
// lb, ub: Interval endpoints (real-valued scalars). Specifies the range [lb, ub] where the wavelet is evaluated. Must satisfy lb ≤ ub.
// n: Number of regularly spaced points in the interval [lb, ub] (positive integer).
// fb: Time-decay parameter of the wavelet (bandwidth in the frequency domain). Must be a positive scalar.
// fc: Center frequency of the complex Shannon wavelet. Must be a positive scalar.
//
// Outputs
// psi: Complex Shannon wavelet evaluated on the n-point regular grid `x` in the interval [lb, ub]. Returned as a 1-by-n vector.
// x: Grid where the complex Shannon wavelet is evaluated. Returned as a 1-by-n vector. The sample points are evenly distributed between lb and ub.
//
// Description
// The `shanwavf` function computes the Complex Shannon wavelet on a regular grid in the interval [lb, ub]. 
// The wavelet is defined by the expression:
//   psi(x) = fb^(1/2) * sinc(fb * x) * exp(2 * %i * %pi * fc * x)
// where `sinc(x) = sin(%pi * x) / (%pi * x)`.
//
// Examples
// // Compute the Complex Shannon wavelet:
//    [psi, x] = shanwavf(2, 8, 3, 1, 6)
//

    funcprot(0);
    rhs=argn(2);
    if (rhs~=5) then
        error ("Wrong number of input arguments.")
    else 
        if (n <= 0 || floor(n) ~= n)
            error("n must be an integer strictly positive");
        elseif (fc <= 0 || fb <= 0)
            error("fc and fb must be strictly positive");
        end
        x = linspace(lb,ub,n);
        sincx=x;
        for i=1:n
            sincx(i)=sin(fb*x(i)*%pi)/(fb*x(i)*%pi);
        end    
        psi = (fb.^0.5).*(sincx.*exp(2.*%i.*%pi.*fc.*x));
    end
endfunction

