function v = pchip(x,y,xx)
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
// x = [0, 1, 2, 3, 4, 5]
// y = [1, 0, 1, 0, 1, 0]
// xx = linspace(0, 5, 800)
// v1 = pchip(x, y)
// v2 = pchip(x, y, xx)
// plot(x, y, 'o', xx, v2)
//
// Authors
// Jitendra Singh
//

// Note
// Execute the function `pchips` prior to executing this function.

if argn(2)==3 & ~isreal(xx)
  error('Points for interpolation must be real.') 
end


nn=size(y,1);

h = diff(x); m = prod(nn);



delta = diff(y,1,2)./repmat(h,m,1);

slopes = zeros(size(y,1),size(y,2));

for r = 1:m
     if isreal(delta)
      slopes(r,:) = pchips(x,y(r,:),delta(r,:));
     else
      realslopes = pchips(x,y(r,:),real(delta(r,:)));   
      imagslopes = pchips(x,y(r,:),imag(delta(r,:)));
      slopes(r,:) = complex(realslopes, imagslopes);
     end
end


s=slopes;
divdif=delta

d = size(y,1); 

dx = diff(x(:).');
dxd = repmat(dx,d,1); 
divdif = diff(y,1,2)./dxd;
n = length(x);
dzzdx = (divdif-s(:,1:n-1))./dxd; dzdxdx = (s(:,2:n)-divdif)./dxd;
dnm1 = d*(n-1);

c1=matrix((dzdxdx-dzzdx)./dxd,dnm1,1)
c2=matrix(2*dzzdx-dzdxdx,dnm1,1) 
c3=matrix(s(:,1:n-1),dnm1,1) 
c4=matrix(y(:,1:n-1),dnm1,1)
v=[c1,c2,c3,c4]


if argn(2)==3   
   //v = ppval(v,xx);
   
   b=x;
   c=v;
   l=length(b)-1;
   dlk=length(c);
   d = size(y,1)
   dl=prod(d)*l;
   eps=2.2204e-16;
   k=fix(dlk/dl+100*eps);
   dd=d;
   lx = length(xx);
   xs = matrix(xx,1,length(xx));
   
   if lx, [cf,idx] = histc([-%inf,b(2:l),%inf], xs);
   else idx=ones(1, length(xx));
             end

  infxs = find(xs==%inf);
   if ~isempty(infxs) 
      index(infxs) = l;
end   
 nogoodxs = find(idx==0);
 
 if ~isempty (nogoodxs)
     xs(nogoodxs) = %nan;      
   idx(nogoodxs) = 1;
end 
     
    
   xs = xs-b(idx);
   
     d = prod(dd);
 
   sizexx = size(xx)
   
   if d>1
   xs = reshape(xs(ones(d,1),:),1,d*lx);
   idx = d*idx; temp = (-d:-1).';
   idx = reshape(1+idx(ones(d,1),:)+temp(:,ones(1,lx)), d*lx, 1 );
  else
   if length(sizexx)>1, dd = []; else dd = 1; end
end


v = c(idx,1);


for i=2:k
   v = xs(:).*v + c(idx,i);
end


if ~isempty(nogoodxs) & k==1 & l>1
   v = matrix(v,d,lx); v(:,nogoodxs) = NaN;
end
v = matrix(v,[dd,sizexx]); 
   
end
    
endfunction
