function [a, v, ref] = levinson(bcf, p)
// Levinson- Durbin Recurssion Algorithm
// 
// Syntax
// a = levinson(r)
// a = levinson(r,n)
// [a,e] = levinson(r,n)
// [a,e,k] = levinson(r,n)
// 
// Parameters
// a :  the coefficients of a length(r)-1 order autoregressive linear process
// e :  the prediction error when order is n
// k :  a column vector containing the reflection coefficients of length n
// 
// Examples
// a = [1 0.1 -0.8];       //Estimate the coefficients of an autoregressive process given by    x(n) = 0.1x(n-1) - 0.8x(n-2) + w(n)
//
// v = 0.4;
// w = sqrt(v)*rand(15000,1,"normal");
// x = filter(1,a,w);
//
// [r,lg] = xcorr(x,'biased');
// r(lg<0) = [];
//
// ar = levinson(r,length(a)-1)
// 


    funcprot(0);


  nargin = argn(2);
  nargout = argn(1);
  [rows columns] = size(bcf)

  if ( nargin<1 )
    error("Wrong input argument ");
  elseif( ~isvector(bcf) | length(bcf)<2 )
    error( "levinson: arg 1 (bcf) must be vector of length >1\n");
  elseif ( nargin>1 & ( ~isscalar(p) | fix(p)~=p ) )
    error( "levinson: arg 2 (p) must be integer >0\n");
  else
    if ((nargin == 1)|(p>=length(bcf))) p = length(bcf) - 1; end
    if( columns >1 ) bcf=bcf(:); end

    if nargout < 3 & p < 100
//      ## direct solution [O(p^3), but no loops so slightly faster for small p]
//      ##   Kay & Marple Eqn (2.39)
      R = toeplitz(bcf(1:p), conj(bcf(1:p)));
      a = R \ -bcf(2:p+1);
      a = [ 1, a.' ];
      v = real( a*conj(bcf(1:p+1)) );
    else
//      ## durbin-levinson [O(p^2), so significantly faster for large p]
//      ##   Kay & Marple Eqns (2.42-2.46)
      ref = zeros(p,1);
      g = -bcf(2)/bcf(1);
      a = [ g ];
      v = real( ( 1 - g*conj(g)) * bcf(1) );
      ref(1) = g;
      for t = 2 : p
        g = -(bcf(t+1) + a * bcf(t:-1:2)) / v;
        a = [ a+g*conj(a(t-1:-1:1)), g ];
        v = v * ( 1 - real(g*conj(g)) ) ;
        ref(t) = g;
      end
      a = [1, a];
    end
  end


endfunction
