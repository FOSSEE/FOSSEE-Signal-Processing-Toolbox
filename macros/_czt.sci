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
// Time-domain signal: two sinusoids at normalized frequencies 0.1 and 0.3
// N = 512;
// n = 0:(N - 1);
// x = sin(2 * %pi * 0.1 * n) + 0.5 * sin(2 * %pi * 0.3 * n);
//
// // === Define Zoom Region ===
// M = 512;         // Number of CZT frequency bins
// f_start = 0.05;  // Start frequency (normalized)
// f_end   = 0.4;   // End frequency (normalized)
//
// // === Define CZT Parameters ===
// w = exp(-2 * %i * %pi * (f_end - f_start) / M);
// a = exp(2 * %i * %pi * f_start);
//
// // Compute Chirp z-Transform
// X_czt = _czt(x, M, w, a);
//
// // Compute standard FFT for comparison
// X_fft = fft1(x, M);
//
// // === Frequency Axes ===
// freq_fft = (0:(M - 1)) / M;  // Normalized frequency for FFT
// freq_czt = f_start + (0:(M - 1)) * (f_end - f_start) / M;  // CZT frequency axis
//
// clf();
// plot2d(freq_fft', abs(X_fft)', style=1);       // Blue solid line for FFT
// plot2d(freq_czt', abs(X_czt)', style=2);       // Red dashed line for CZT
//
// legend(["Standard FFT", "Zoomed CZT"]);
// xlabel("Normalized Frequency");
// ylabel("|X(f)|");
// xtitle("Zoomed Spectrum using Chirp z-Transform");

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
        w = exp(2*%i*%pi/m);
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

B
B
B
B
B
B
B
B
A
A
A
A

i

