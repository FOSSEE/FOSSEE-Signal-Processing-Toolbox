/* spectral_adf  
  Calling Sequence
      spectral_adf (c)
      spectral_adf (c, win)
      spectral_adf (c, win, b)
  Parameters
      c : Vector of autocovariances
      win : The window name . Default window is "triangle"
      b : Bandwidth. Default is 1/sqrt(length(c))
  Description
      Return the spectral density estimator given a vector of autocovariances c, window name win, and bandwidth, b.
      The window name, e.g., "triangle" or "rectangle" is used to search for a function called win_lw.
      If win is omitted, the triangle window is used.
      If b is omitted, 1 / sqrt (length (c)) is used.
  Dependencies: fft1  */
function sde = spectral_adf (c, win, b)
    //c should be a vector
    if ~isvector(c)
      error("spectral_adf: input c should be a vector")
    end
    // maximum along the columns
    function max_value = col_max (A)
      max_value = zeros ( 1, size(A,2))
      for i = 1:length(max_value)
          max_value(i) = max(A(:,i))
      end
    endfunction
    //window functions
    function c = triangle_lw (n, b)
      c = 1 - (0 : n-1)' * b;
      c = [c' ; zeros(1, n)]
      c = col_max (c)'
    endfunction
    function c = rectangle_lw (n, b)
      c = zeros (n, 1);
      t = floor (1 / b);
      c(1:t) = 1;
    endfunction
    // main part
    nargin = argn(2)
    if (nargin < 1)
      error("wrong number of inputs.");
    end
    cr = max(size (c) );
    if (size (c , 2) > 1)
      c = c';
    end
    if (nargin < 3)
      b = 1 / ceil (sqrt (cr));
    end
    if (nargin == 1)
      w = triangle_lw (cr, b);
    elseif (~ (type (win) == 10) )
      error ("spectral_adf: WIN must be a string");
    elseif (~strcmp (win , "rectangle" ) )
      w = rectangle_lw(cr , b) ;
    elseif (~strcmp (win , "triangle" ) ) 
        w = triangle_lw(cr , b) ;
    else 
        error("Invalid window or this window is not supported yet")
    end 
    c=c .* w;
    sde = 2 * real (fft1 (c)) - c(1);
    zer= zeros(cr, 1);
    sde = [zer sde];
    sde(:, 1) = (0 : cr-1)' / cr;
  endfunction
