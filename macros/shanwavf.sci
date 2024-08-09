/*Description
    Compute the Complex Shannon wavelet.
    The complex Shannon wavelet is defined by a bandwidth parameter fb, a wavelet center frequency fc, and the expression
    psi(x) = f * b^{1/2}sinc(fb . x) e^{2 pi i f c x}
    on an n-point regular grid in the interval of lb to ub.
Calling Sequence
    [psi, x]= shanwavf(lb, ub, n, fb, fc)
Input  Parameters
    lb, ub (Real valued scalers) : Interval endpoints lb ≤ ub, specified as a pair of real-valued scalars.
    n (Real valued integer strictly positive)` : Number of regularly spaced points in the interval [lb,ub], specified as a positive integer.
    fb	: Time-decay parameter of the wavelet (bandwidth in the frequency domain). Must be a positive scalar.
    fc	: Center frequency of the complex Shannon wavelet, specified as a positive scalar.
Output Parameters
     psi : Complex Shannon wavelet evaluated on the n point regular grid x in the interval [lb,ub], returned as a 1-by-n vector.
     x   : Grid where the complex Shannon wavelet is evaluated, returned as a 1-by-n vector. The sample points are evenly distributed between lb and ub.
Examples
      1.[a,b]=shanwavf (2,8,3,1,6)
           a =   [-3.8982e-17 + 1.1457e-31i   3.8982e-17 - 8.4040e-31i  -3.8982e-17 + 4.5829e-31i]
           b =   [2   5   8]   */
function [psi,x]=shanwavf(lb,ub,n,fb,fc)
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

