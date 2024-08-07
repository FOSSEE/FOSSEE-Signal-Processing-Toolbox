//This is a Signal Processing toolbox function
//Author: Rashmi Patankar, FOSSEE IIT Bombay
// y = filtfilt (b, a, x)
//Forward and reverse filter the signal. 
//This corrects for phase distortion introduced by a one-pass filter, though it does square the magnitude response in the process. That’s the theory at least. In practice the phase correction is not perfect, and magnitude response is distorted, particularly in the stop band. 
//Example 
//[b, a]=butter(3, 0.1);                  # 5 Hz low-pass filter
//t = 0:0.01:1.0;                         # 1 second sample
//x=sin(2*pi*t*2.3)+0.25*randn(size(t));  # 2.3 Hz sinusoid+noise
//y = filtfilt(b,a,x); z = filter(b,a,x); # apply filter
//plot(t,x,';data;',t,y,';filtfilt;',t,z,';filter;')
 

function y = filtfilt(b, a, x)

  // Check for correct number of input arguments
  if nargin() ~= 3 then
    error("filtfilt: Wrong number of input arguments");
  end

  // Handle row vectors
  rotate = (size(x,1)==1);
  if rotate then
    x = x(:); // Make it a column vector
  end

  // Get dimensions and lengths
  lx = size(x,1);
  a = a(:).';
  b = b(:).';
  lb = length(b);
  la = length(a);
  n = max(lb, la);
  lrefl = 3 * (n - 1);
  if la < n then 
      a(n) = 0; 
  end
  if lb < n then 
      b(n) = 0; 
  end

  // Check input length
  if (size(x, 1) <= lrefl) then
    error("filtfilt: X must be a vector or matrix with length greater than " + string(lrefl));
  end

  // Compute initial state
  kdc = sum(b) / sum(a);
  if (abs(kdc) < %inf) then // Neither NaN nor +/- Inf
    si = flipdim(cumsum(flipdim(b - kdc * a, 2)), 2);
  else
    si = zeros(size(a)); // Fall back to zero initialization
  end
  si(1) = [];
  si = [si 0];  // Append a zero to si
  si = si(1:(max(length(a), length(b)) - 1));
  si = si';
  disp(size(si));
  // Filter each column
  for c = 1:size(x,2)
   // v = x(:);  // Convert single column to row vector
    v = [2*x(1,c)-x((lrefl+1):-1:2,c); x(:,c); 2*x($,c)-x(($-1):-1:$-lrefl,c)];

    // Forward and reverse filtering
    v = filter(b, a, v, si*v(1));  // Forward filter
    v = flipdim(filter(b, a, flipdim(v, 1), si*v($)), 1);  // Reverse filter
    y(:,c) = v((lrefl+1):(lx+lrefl));
    y(:,c) = y(:)';  // Transpose back to column vector
  end

  // Handle row vectors
  if rotate then
    y = flipdim(y, 2) // Rotate it back
  end

endfunction

/*
Test case 1:
b = [1 2];  
a = [1 -0.5];
x = [1 2 3 4];
y = filtfilt(b, a, x)
Output: 38.396851  71.793701  105.08740  136.92480

Test case 2:
b = [0.2, 0.2];
a = [1, -0.8];
x = [1, 2, 3, 4, 5];
y = filtfilt(b, a, x)
Output:  5.0357884  7.2211355  9.3675393  11.382320  13.166217

Test case 3:
b = [1 2 5];
a = [1 6 8];
x = [1 2 3 4 5 6 7];
y = filtfilt(b, a, x)

Test case 4:
b = [1, 2, 5, 7, 9];
a = [1, -0.5, 8, 4, 3];
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 3, 5, 7];
y = filtfilt(b, a, x)
*/
