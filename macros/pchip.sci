function v = pchip(x,y,xx)
          
//this function returns piecewise cubic hermite interpolating polynomial.

// Calling Sequence
// d=pchip(x,y)
// d= pchip(X,,y,xx) 
   
    
// Parameters
// x: a vector
// y: is Y is vector then it must have the same length as x and Y is matrix then  the last dimension of Y must equal length(X).
// xx: Points for interpolation
// v: vector of interpolantant at xx
    
// Examples
// x=[0 1 2 3 4 5]
// y=[1 0 1 0 1 0]
// xx=linspace(0:10,800)
// v=pchip(x, y) 
// v=pchip(x,y,xx)
// See also
 // Authors
// Jitendra Singh

// execute function "pchips" prior executing this function
        

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



