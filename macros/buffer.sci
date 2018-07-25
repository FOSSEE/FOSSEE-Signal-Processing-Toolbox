//This function buffers the given data into a matrix of signal frames
//Calling Sequence
//[y] = buffer (x, n)
//[y] = buffer (x, n, p)
//[y] = buffer (x, n, p)
//[y, z, opt] = buffer (...)
//Parameters
//x: Data to be buffered
//n: Positive integer equal to number of rows in the produced data buffer
//p: Integer less than n, default value 0
//opt: In case of overlap, it can be a vector of length p or the string "nodelay", In case of underlap, it is an integer between 0 and p
//Description
//This function buffers the given data into a matrix of signal frames
//Examples
//buffer(1,3,2)
//ans =
//   0   0
//   0   1
//   1   0

//Older code

//function [y, z, opt] = buffer (x, n, p, opt)
//funcprot(0);
//lhs = argn(1)
//rhs = argn(2)
//if (rhs < 2 | rhs > 4)
//error("Wrong number of input arguments.")
//end
//
//select(rhs)
//
//	case 2 then
//		if(lhs==1)
//		y = callOctave("buffer",x,n)
//		elseif(lhs==3)
//		[y,z,opt] = callOctave("buffer",x,n)
//		else
//		error("Wrong number of output argments.")
//		end
//
//	case 3 then
//		if(lhs==1)
//		y = callOctave("buffer",x,n,p)
//		elseif(lhs==3)
//		[y,z,op] = callOctave("buffer",x,n,p)
//		else
//		error("Wrong number of output argments.")
//	       	end
//	case 4 then
//		if(lhs==1)
//		y = callOctave("buffer",x,n,p,opt)
//		elseif(lhs==3)
//		[y,z,opt] = callOctave("buffer",x,n,p,opt)
//		else
//		error("Wrong number of output argments.")
//	       	end
//	end
//endfunction


function [y, z, opt] = buffer (x, n, p, opt)

  [nargout, nargin] = argn() ;

  if (nargin < 2 | nargin > 4)
    error("buffer : invalid input");
  end
  if  (~isscalar (n) | n ~= floor (n))
    error ("buffer: n must be an integer");
  end
  if (nargin < 3)
    p = 0;
  elseif (~isscalar (p) | p ~= floor (p) | p >= n)
    error ("buffer: p must be an integer less than n");
  end
  if (nargin <  4)
    if (p < 0)
      opt = 0;
    else
      opt = zeros (1, p);
    end
  end

  [rows_x columns_x] = size(x) ;

  if (rows_x == 1)
    isrowvec = %T;
  else
    isrowvec = %F;
  end

  if (p < 0)
    if (isscalar (opt) & opt == floor (opt) & opt >= 0 & opt <= -p)
      lopt = opt;
    else
      error ("buffer: expecting fourth argument to be and integer between 0 and -p");
    end
  else
    lopt = 0;
  end

  x = x (:);
  l = length (x);
  m = ceil ((l - lopt) / (n - p));
  y = zeros (n - p, m);
  y (1 : l - lopt) = x (lopt + 1 : $);
  if (p < 0)
    y ($ + p + 1 : $, :) = [];
  elseif (p > 0)
    if (type(opt) == 10)
      if (strcmp (opt, "nodelay"))
        y = [y ; zeros(p, m)];
        if (p > n / 2)
          is = n - p + 1;
          in = n - p;
          ie = is + in - 1;
          off = 1;
          while (in > 0)
            y (is : ie, 1 : $ - off) = y (1 : in, 1 + off : $);
            off = off + 1;
            is = ie + 1;
            ie = ie + in;
            if (ie > n)
              ie = n;
            end
            in = ie - is + 1;
          end
          [i, j] = ind2sub([n-p, m], l);
          if (all ([i, j] == [n-p, m]))
            off = off -1 ;
          end
          y (:, $ - off + 2 : $) = [];
        else
          y ($ - p + 1 : $, 1 : $ - 1) = y (1 : p, 2 : $);
          if (sub2ind([n-p, m], p, m) >= l)
            y (:, $) = [];
          end
        end
      else
        error ("buffer: unexpected string argument");
      end
    elseif (isvector (opt))
      if (length (opt) == p)
        lopt = p;
        y = [zeros(p, m); y];
        in = p;
        off = 1;
        while (in > 0)
          y (1 : in, off) = opt(off:$);
          off = off + 1;
          in = in - n + p;
        end
        if (p > n / 2)
          in = n - p;
          ie = p;
          is = p - in + 1;
          off = 1;
          while (ie > 0)
            y (is : ie, 1 + off : $) = ...
              y ($ - in + 1 : $, 1 : $ - off);
            off = off + 1;
            ie = is - 1;
            is = is - in;
            if (is < 1)
              is = 1;
            end
            in = ie - is + 1;
          end
        else
          y (1 : p, 2 : $) = y ($ - p + 1 : $, 1 : $ - 1);
        end
      else
        error ("buffer: opt vector must be of length p");
      end
    else
      error ("buffer: unrecognized fourth argument");
    end
  end
  if (nargout > 1)
    if (p >= 0)
      [i, j] = ind2sub (size(y), l + lopt + p * (size (y, 2) - 1));
      if (any ([i, j] ~= size (y)))
        z = y (1 + p : i, $);
        y (:, $) = [];
      else
        z = zeros (0, 1);
      end
    else
      [i, j] = ind2sub (size (y) + [-p, 0], l - lopt);
      if (i < size (y, 1))
        z = y (1: i, $);
        y (:, $) = [];
      else
        z = zeros (0, 1);
      end
    end
    if (isrowvec)
      z = z.';
    end
    if (p < 0)
      opt = max(0, size (y, 2) * (n - p) + opt - l);
    elseif (p > 0)
      opt = y($-p+1:$)(:);
    else
      opt = [];
    end
  end
endfunction
