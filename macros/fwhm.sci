function myfwhm = fwhm(y, varargin)
// Compute peak full-width at half maximum (FWHM) or at another level of peak maximum for vector or matrix data.
//
// Syntax
//   f = fwhm(y)
//   f = fwhm(x, y)
//   f = fwhm(…, "zero")
//   f = fwhm(…, "min")
//   f = fwhm(…, "alevel", level)
//   f = fwhm(…, "rlevel", level)
//
// Parameters
// y: Vector or matrix. If `y` is a matrix, FWHM is calculated for each column as a row vector.
// x: (optional) Vector specifying the sampling points of `y`. If not provided, `x` defaults to 1:length(y).
// "zero": (optional) Default option. Computes FWHM at half maximum, i.e., 0.5 * max(y).
// "min": (optional) Computes FWHM at the middle curve, i.e., 0.5 * (min(y) + max(y)).
// "alevel": (optional) Computes full-width at the given absolute level of `y`. Requires an additional argument `level`.
// "rlevel": (optional) Computes full-width at the given relative level of peak profile. Requires an additional argument `level`.
// level: (optional) Scalar specifying the absolute or relative level for FWHM computation.
//
// Outputs
// f: Full-width at the specified level. If FWHM does not exist (e.g., for a monotonous function), returns 0.
//
// Description
// The `fwhm` function computes the full-width at half maximum (FWHM) or at another specified level for vector or matrix data `y`. 
// If `y` is a matrix, the function computes FWHM for each column and returns the results as a row vector. The function supports 
// several options for specifying the level at which the width is computed:
//
// - "zero" (default): Computes FWHM at half maximum, i.e., 0.5 * max(y).
// - "min": Computes FWHM at the middle curve, i.e., 0.5 * (min(y) + max(y)).
// - "rlevel": Computes full-width at the given relative level of the peak profile, i.e., at `rlevel * max(y)` or 
//   `rlevel * (min(y) + max(y))`. For example, `fwhm(…, "rlevel", 0.1)` computes the full width at 10% of the peak maximum. 
//   FWHM is equivalent to `fwhm(…, "rlevel", 0.5)`.
// - "alevel": Computes full-width at the given absolute level of `y`.
//
// The function returns 0 if FWHM does not exist (e.g., for a monotonous function or if the function does not intersect the 
// horizontal line at the specified level).
//
// Examples
// fwhm([1,2,3;9,-7,0.6],[4,5,6])
//
// Authors
// FOSSEE Team
// toolbox@scilab.in


  funcprot(0);
  if nargin < 1 || nargin > 5
    error("Wrong number of input arguments.");
  end
  opt = 'zero';
  is_alevel = 0;
  level = 0.5;
  if nargin == 1
        x = 1:max(size(y));
  else
    if type(varargin(1)) == 10
      x = 1:max(size(y));
      k = 1;
    else
      x = y;
      y = varargin(1);
      k = 2;
    end
    while k <= max(size(varargin))
      if ~strcmp(varargin(k), 'alevel')
        is_alevel = 1;
        k = k+1;
        if k > max(size(varargin))
          error('option alevel requires an argument');
        end
        level = varargin(k);
        if ~isreal(level) || max(size(level)) > 1
          error('argument of alevel must be real number');
        end
        k = k+1;
        break
      end
      if (~strcmp(varargin(k), 'zero') || ~strcmp(varargin(k), 'min'))
        opt = varargin(k);
        k = k+1;
      end
      if k > max(size(varargin)) break; end
      if ~strcmp(varargin(k), 'rlevel')
        k = k+1;
        if k > max(size(varargin))
          error('option rlevel requires an argument');
        end
        level = varargin(k);
        if ~isreal(level) || max(size(level)) > 1 || level(1) < 0 || level(:) > 1
          error('argument of rlevel must be real number from 0 to 1 (it is 0.5 for fwhm)');
        end
        k = k+1;
        break
      end
      break
    end
    if k ~= max(size(varargin))+1
      error('fwhm: extraneous option(s)');
    end
  end

  // test the y matrix
  [nr, nc] = size(y);
  if (nr == 1 & nc > 1) then
    y = y';
    nr = nc;
    nc = 1;
  end

  if max(size(x)) ~= nr then
    error('dimension of input arguments do not match');
  end

  // Shift matrix columns so that y(+-xfwhm) = 0:
  if is_alevel then
    // case: full-width at the given absolute position
    y = y - level;
  else
    if opt == 'zero' then
      // case: full-width at half maximum
      y = y - level * repmat(mtlb_max(y), nr, 1);
    else
      // case: full-width above background
      y = y - level * repmat((mtlb_max(y) + mtlb_min(y)), nr, 1);
    end
  end

  myfwhm = zeros(1, nc); // default: 0 for fwhm undefined
  for n = 1:nc
    yy = y(:, n);
    ind = find((yy(1:$ - 1) .* yy(2:$)) <= 0);
    if mtlb_max(size(ind)) >= 2 & yy(ind(1)) > 0 then // must start ascending
      ind = ind(2:$);
    end
    [mx, imax] = mtlb_max(yy); // protection against constant or (almost) monotonous functions
    if max(size(ind)) >= 2 & imax >= ind(1) & imax <= ind($) then
      ind1 = ind(1);
      ind2 = ind1 + 1;
      xx1 = x(ind1) - yy(ind1) * (x(ind2) - x(ind1)) / (yy(ind2) - yy(ind1));
      ind1 = ind($);
      ind2 = ind1 + 1;
      xx2 = x(ind1) - yy(ind1) * (x(ind2) - x(ind1)) / (yy(ind2) - yy(ind1));
      myfwhm(n) = xx2 - xx1;
    end
  end
endfunction

//tests:
//x = -%pi:0.001:%pi; y = cos(x);
//assert_checkalmostequal(fwhm(x, y), 2.094395, 0.5*10^-5);
//assert_checktrue( abs(fwhm(x, y) - 2*%pi/3) < 0.01 );

//assert_checktrue(fwhm(-10:10) == 0 && fwhm(ones(1,50)) == 0);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhm(x,y)-0.75)<0.001 && abs(fwhm(x,y,'zero')-0.75) < 0.001 && abs(fwhm(x,y,'min')-1.0) < 0.001);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhm(x,y, 'rlevel', 0.1)-1.35) < 0.001 && abs(fwhm(x,y,'zero', 'rlevel', 0.1)-1.35) < 0.001 && abs(fwhm(x,y,'min', 'rlevel', 0.1)-1.40) < 0.001);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhm(x,y, 'alevel', 2.5)-0.25) < 0.001 && abs(fwhm(x,y,'alevel', -0.5)-1.75) < 0.001);

//x=-10:10;
//assert_checktrue(fwhm(x.*x) == 0);

//x=-5:5;
//y=18-x.*x;
//assert_checktrue( abs(fwhm(y)-6.0) < 0.001 && abs(fwhm(x,y,'zero')-6.0) < 0.001 && abs(fwhm(x,y,'min')-7.0 ) < 0.001);
