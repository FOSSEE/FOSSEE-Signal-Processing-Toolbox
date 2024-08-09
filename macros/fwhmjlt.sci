function myfwhm = fwhmjlt(y, varargin)
//This function computes peak full width at half minimum or at another level of peak minimum for vector or matrix data y supplied as input.
//Calling Sequence:
//f = fwhmjlt(y)
//f = fwhmjlt(x, y)
//f = fwhmjlt(…, "zero")
//f = fwhmjlt(…, "min")
//f = fwhmjlt(…, "alevel", level)
//f = fwhmjlt(…, "rlevel", level)
//Parameters:
//y- vector or matrix. If y is a matrix, fwhm is calculated for each column as a row vector.
//The second argument is by default "zero" which computes the fwhm at half maximum. If it is "min", fwhm is computed at middle curve.
//The option "rlevel" computes full-width at the given relative level of peak profile.
//The option "alevel" computes full-width at the given absolute level of y.
//Description:
//This function computes peak full width at half minimum or at another level of peak minimum for vector or matrix data y supplied as input.
//This function returns 0 if FWHM does not exist.
//Examples:
//t=-50:0.01:50;
//y=(1/(2*sqrt(2*%pi)))*exp(-(t.^2)/8);
//z=fwhmjlt(y)
//Output: 470.96442

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
      error('fwhmjlt: extraneous option(s)');
    end
  end

  [nr, nc] = size(y);
  if (nr == 1 & nc > 1) then
    y = y';
    nr = nc;
    nc = 1;
  end

  if max(size(x)) ~= nr then
    error('dimension of input arguments do not match');
  end

  if is_alevel then
    y = y - level;
  else
    if opt == 'zero' then
      y = y - level * repmat(mtlb_max(y), nr, 1);
    else
      y = y - level * repmat((mtlb_max(y) + mtlb_min(y)), nr, 1);
    end
  end

  myfwhm = zeros(1, nc);
  for n = 1:nc
    yy = y(:, n);
    ind = find((yy(1:$ - 1) .* yy(2:$)) <= 0);
    if mtlb_max(size(ind)) >= 2 & yy(ind(1)) > 0
      ind = ind(2:$);
    end
    [mx, imax] = mtlb_max(yy);
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
//assert_checkalmostequal(fwhmjlt(x, y), 2.094395, 0.5*10^-5);
//assert_checktrue( abs(fwhmjlt(x, y) - 2*%pi/3) < 0.01 );

//assert_checktrue(fwhmjlt(-10:10) == 0 && fwhmjlt(ones(1,50)) == 0);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhmjlt(x,y)-0.75)<0.001 && abs(fwhmjlt(x,y,'zero')-0.75) < 0.001 && abs(fwhmjlt(x,y,'min')-1.0) < 0.001);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhmjlt(x,y, 'rlevel', 0.1)-1.35) < 0.001 && abs(fwhmjlt(x,y,'zero', 'rlevel', 0.1)-1.35) < 0.001 && abs(fwhmjlt(x,y,'min', 'rlevel', 0.1)-1.40) < 0.001);

//x=1:3;
//y=[-1,3,-1];
//assert_checktrue(abs(fwhmjlt(x,y, 'alevel', 2.5)-0.25) < 0.001 && abs(fwhmjlt(x,y,'alevel', -0.5)-1.75) < 0.001);

//x=-10:10;
//assert_checktrue(fwhmjlt(x.*x) == 0);

//x=-5:5;
//y=18-x.*x;
//assert_checktrue( abs(fwhmjlt(y)-6.0) < 0.001 && abs(fwhmjlt(x,y,'zero')-6.0) < 0.001 && abs(fwhmjlt(x,y,'min')-7.0 ) < 0.001);
