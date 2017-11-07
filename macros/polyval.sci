function [y, delta] = polyval(p,x,S,mu)

// Check input is a vector
if ~(isvector(p) | isempty(p))
    error(message('polyval:InvalidP'));
end

nc = length(p);
if isscalar(x) & (argn(2) < 3) & nc>0 & isfinite(x) & all(isfinite(p(:)))
    // Make it scream for scalar x.  Polynomial evaluation can be
    // implemented as a recursive digital filter.
    y = filter(1,[1 -x],p);
    y = y(nc);
    return
end

siz_x = size(x);
if argn(2) == 4
   x = (x - mu(1))/mu(2);
end

// Use Horner's method for general case where X is an array.
y = zeros(size(x,1),size(x,2));
if nc>0, y(:) = p(1); end
for i=2:nc
    y = x .* y + p(i);
end

if argn(1) > 1
    if argn(2) < 3 | isempty(S)
        error(message('polyval:RequiresS'));
    end
    
    // Extract parameters from S
    if isstruct(S),  // Use output structure from polyfit.
      R = S.R;
      df = S.df;
      normr = S.normr;
    else             // Use output matrix from previous versions of polyfit.
      [ms,ns] = size(S);
      if (ms ~= ns+2) | (nc ~= ns)
          error(message('polyval:SizeS'));
      end
      R = S(1:nc,1:nc);
      df = S(nc+1,1);
      normr = S(nc+2,1);
    end

    // Construct Vandermonde matrix for the new X.
    x = x(:);
    V(:,nc) = ones(length(x),1,class(x));
    for j = nc-1:-1:1
        V(:,j) = x.*V(:,j+1);
    end

    // S is a structure containing three elements: the triangular factor of
    // the Vandermonde matrix for the original X, the degrees of freedom,
    // and the norm of the residuals.
    E = V/R;
    e = sqrt(1+sum(E.*E,2));
    if df == 0
        warning(message('polyval:ZeroDOF'));
        delta = Inf(size(e));
    else
        delta = normr/sqrt(df)*e;
    end
    delta = reshape(delta,siz_x);
end
endfunction

