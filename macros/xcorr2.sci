/*Calling Sequence
        c = xcorr2 (a)
        c = xcorr2 (a, b)
        c = xcorr2 (a, b, scale)
Description:
        Compute the 2D cross-correlation of matrices a and b.
        If b is not specified, computes autocorrelation of a, i.e., same as xcorr (a, a).
        The optional argument scale, defines the type of scaling applied to the cross-correlation matrix. Possible values are:
        "none" (default)
            No scaling.
        "biased"
            Scales the raw cross-correlation by the maximum number of elements of a and b involved in the generation of any element of c.
        "unbiased"
            Scales the raw correlation by dividing each element in the cross-correlation matrix by the number of products a and b used to generate that element.
        "coeff"
            Scales the normalized cross-correlation on the range of [0 1] so that a value of 1 corresponds to a correlation coefficient of 1.
  Examples
        xcorr2(5,0.8,'coeff')
            ans =  1 */
function c = xcorr2 (a, b, scale)
  funcprot(0);
  nargin=argn(2);
  if nargin < 3 then
    scale = "none"
  end
  if (nargin < 1 || nargin > 3)
    error("Wrong number of inputs")
  elseif (nargin == 2 && type (b) == 10 )
    scale = b;
    b        = a;
  elseif (nargin == 1)
    // we have to set this case here instead of the function line, because if
    // someone calls the function with zero argument, since a is never set, we
    // will fail with "`a' undefined" error rather that print_usage
    b = a;
  end
  if (ndims (a) ~= 2 || ndims (b) ~= 2)
    error ("xcorr2: input matrices must must have only 2 dimensions");
  end
  // compute correlation
  [ma,na] = size(a);
  [mb,nb] = size(b);
  c = conv2 (a, conj (b (mb:-1:1, nb:-1:1)));
  // bias routines by Dave Cogdell (cogdelld@asme.org)
  // optimized by Paul Kienzle (pkienzle@users.sf.net)
  // coeff routine by Carnë Draug (carandraug+dev@gmail.com)
  switch  (scale)
    case {"none"}
      // do nothing, it's all done
    case {"biased"}
      c = c / ( min ([ma, mb]) * min ([na, nb]) );
    case {"unbiased"}
      lo   = min ([na,nb]);
      hi   = max ([na, nb]);
      row  = [ 1:(lo-1), lo*ones(1,hi-lo+1), (lo-1):-1:1 ];
      lo   = min ([ma,mb]);
      hi   = max ([ma, mb]);
      col  = [ 1:(lo-1), lo*ones(1,hi-lo+1), (lo-1):-1:1 ]';
      bias = col*row;
      c    = c./bias;
    case {"coeff"}
      a = double (a);
      b = double (b);
      a = conv2 (a.^2, ones (size (b,1) , size( b ,2)));
      b = sum(b(:).* conj(b(:)));
      c(:,:) = c(:,:) ./ sqrt (a(:,:) * b);
    else
      error ("xcorr2: invalid type of scale %s", scale);
  end
endfunction
