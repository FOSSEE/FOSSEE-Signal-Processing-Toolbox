function y = _czt(x, m, w, a)
// Compute the Chirp z-transform.
//
// Syntax
//   y = _czt(x)
//   y = _czt(x, m)
//   y = _czt(x, m, w)
//   y = _czt(x, m, w, a)
//
// Parameters
// x: Input scalar or vector.
// m: Total number of steps. Default is the length of the input signal.
// w: Ratio between points in each step. Default is exp(-2*%i*%pi/m).
// a: Starting point in the complex plane. Default is 1.
//
// Description
// The `czt` function computes the Chirp z-transform of the input signal `x`. 
// It calculates the frequency response starting at `a` and stepping by `w` for `m` steps. 
// The parameter `a` is a point in the complex plane, and `w` is the ratio between points in each step. 
// The radius increases exponentially, and the angle increases linearly.
//
// Examples
// // Determine the frequency components of a signal
// t = linspace(0, 50, 1000); 
// f = linspace(0, 3, 1000);    
// x_t = sin(t) + cos(t * 2 * %pi);  
// x_f = _czt(x_t);   
// plot(f, abs(x_f))

    funcprot(0);
    nargin=argn(2);
    if nargin < 1 || nargin > 4 then
        error("Please input valid number of arguments");
    end
    [row, col] = size(x);
    if row == 1 then
        x = x(:); col = 1;
    end
    if nargin < 2 || isempty(m) then
        m = max(size(x(:,1)));
    end
    if max(size(m) ) > 1 then
        error("czt: m must be a single element\n");
    end
    if nargin < 3 || isempty(w) then
        w = exp(-2*%i*%pi/m);
    end
    if nargin < 4 || isempty(a) then
        a = 1;
    end
    if max(size(w)) > 1 then
        error("czt: w must be a single element\n");
    end
    if max(size(a)) > 1 then
        error("czt: a must be a single element\n");
    end
    // indexing to make the statements a little more compact
    n = max(size(x(:,1)));
    N = [0:n-1]'+n;
    NM = [-(n-1):(m-1)]'+n;
    M = [0:m-1]'+n;
    nfft = 2^nextpow2(n+m-1); // fft pad
    W2 = w.^(([-(n-1):max(m-1,n-1)]'.^2)/2); // chirp
    for idx = 1:col
        fg = fft1(x(:,idx).*(a.^-(N-n)).*W2(N), nfft);
        fw = fft1(1./W2(NM), nfft);
        gg = ifft1(fg.*fw, nfft);
        y(:,idx) = gg(M).*W2(M);
    end
    if row == 1, y = y.';
    end
    y = clean ( y ) ;
endfunction

