function d = pchips(x,y,delta)
// Compute the piecewise cubic Hermite interpolating polynomial.
//
// Syntax
//   v = pchip(x, y)
//   v = pchip(x, y, xx)
//
// Parameters
// x: A vector of input data points.
// y: A vector or matrix of function values at the points in `x`. If `y` is a vector, it must have the same length as `x`. If `y` is a matrix, the last dimension of `y` must equal the length of `x`.
// xx: (optional) Points for interpolation.
//
// Description
// The `pchip` function computes the piecewise cubic Hermite interpolating polynomial for the given data points `x` and `y`. 
// If the optional parameter `xx` is provided, the function evaluates the interpolating polynomial at the points in `xx`.
//
// Examples
// x = [0, 1, 2, 3, 4, 5];
// y = [1, 0, 1, 0, 1, 0];
// xx = linspace(0, 5, 800);
// v1 = pchip(x, y);
// v2 = pchip(x, y, xx);
// plot(x, y, 'o', xx, v2)
//
// Authors
// Jitendra Singh
//

// Note
// Execute the function `pchips` prior to executing this function.

   n = length(x);

   if n==2
      d = repmat(delta(1),size(y));

  else


   d = zeros(size(y));

   k = find(sign(delta(1:n-2)).*sign(delta(2:n-1)) > 0);


   h = diff(x);
   hs = h(k)+h(k+1);
   w1 = (h(k)+hs)./(3*hs);
   w2 = (hs+h(k+1))./(3*hs);

   if ~isempty (k) then


   del_mx = max(abs(delta(k)), abs(delta(k+1)));
   del_mn = min(abs(delta(k)), abs(delta(k+1)));
   d(k+1) = del_mn./conj(w1.*(delta(k)./del_mx) + w2.*(delta(k+1)./del_mx));
 else

   d(1) = ((2*h(1)+h(2))*delta(1) - h(1)*delta(2))/(h(1)+h(2));
   if sign(d(1)) ~= sign(delta(1))
      d(1) = 0;
   elseif (sign(delta(1)) ~= sign(delta(2))) & (abs(d(1)) > abs(3*delta(1)))
      d(1) = 3*delta(1);
   end
   d(n) = ((2*h(n-1)+h(n-2))*delta(n-1) - h(n-1)*delta(n-2))/(h(n-1)+h(n-2));
   if sign(d(n)) ~= sign(delta(n-1))
      d(n) = 0;
   elseif (sign(delta(n-1)) ~= sign(delta(n-2))) & (abs(d(n)) > abs(3*delta(n-1)))
      d(n) = 3*delta(n-1);
   end
   end




   end

   endfunction
