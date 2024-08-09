/* Description
        Return the spectral density estimator given a data vector x, window name win, and bandwidth, b.
        The window name, e.g., "triangle" or "rectangle" is used to search for a function called win_sw.
        If win is omitted, the triangle window is used.
        If b is omitted, 1 / sqrt (length (x)) is used.
    Calling Sequence
        spectral_xdf (x)
        spectral_xdf (x, win)
        spectral_xdf (x, win, b)
    Parameters
        x : Data vector
        win : the window name . Default "triangle" is used .
        b : Bandwidth . Default value 1/sqrt(length(x))
Dependencies:fft1 ifft1 */
function sde = spectral_xdf (x, win, b)
    // check x is a vector or not
    if ~isvector(x) 
        error("spectral_xdf :  x must a data vector")
    end
    // available windows - rectangle
    function c = rectangle_sw (n, b)
          c = zeros (n, 1);
          c(1) = 2 / b + 1;
          l = (2:n)' - 1;
          l = 2 * %pi * l / n;
          c(2:n) = sin ((2/b + 1) * l / 2) ./ sin (l / 2);
    endfunction
    // triangle
    function retval = triangle_sw (n, b)
          retval = zeros (n,1);
          retval(1) = 1 / b;
          l = (2:n)' - 1;
          l = 2 * %pi * l / n;
          retval(2:n) = b * (sin (l / (2*b)) ./ sin (l / 2)).^2;
    endfunction
    // main function
    nargin = argn(2)
    if (nargin < 1)
      error("invalid inputs");
    end
    xr = max(size (x) );
    if (size (x, 2) > 1)
      x = x';
    end
    if (nargin < 3)
      b = 1 / ceil (sqrt (xr));
    end
    if (nargin == 1)
      w = triangle_sw (xr, b);
    elseif (~ (type(win)== 10))
      error ("spectral_xdf: WIN must be a string");
    elseif (~strcmp (win , "triangle" ) ) 
        w = triangle_sw (xr , b);
    elseif (~strcmp (win , "rectangle" ) )     
        w = rectangle_sw ( xr , b);
    else
      error("Invalid window or this window is not supported yet");
    end
    x = x - sum (x) / xr;
    sde = (abs (fft1 (x)) / xr).^2;
    sde = real (ifft1 (fft1 (sde) .* fft1 (w)));
    zer = zeros(xr,1);
    sde = [zer sde];
    sde(:, 1) = (0 : xr-1)' / xr;
    sde = clean(sde);
endfunction
