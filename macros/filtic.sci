function zf = filtic(b,a,y,x)
// Find the initial conditions for the delays in the transposed direct-form II filter implementation.
//
// Syntax
//   zf = filtic(b, a, y)
//   zf = filtic(b, a, y, x)
//
// Parameters
// b: Vector of real or complex numbers. Represents the numerator coefficients of the filter's transfer function.
// a: Vector of real or complex numbers. Represents the denominator coefficients of the filter's transfer function.
// y: Vector of real or complex numbers. Represents the initial output values.
// x: Vector of real or complex numbers (optional). Represents the initial input values. Defaults to an empty vector if not provided.
// zf: Vector. The initial conditions for the delays in the transposed direct-form II filter implementation.
//
// Description
// This function finds the initial conditions for the delays in the transposed direct-form II filter implementation. 
// The vectors `b` and `a` represent the numerator and denominator coefficients of the filter's transfer function.
//
// Examples
// zf = filtic([%i, 1, -%i, 5], [1, 2, 3*%i], [0.8*%i, 7, 9])
// ans =
//    0.00000 - 22.60000i
//    2.40000 +  0.00000i
//    0.00000 +  0.00000i
//

  if (argn(2)>4 | argn(2)<3) | (argn(1)>1)
    error("Wrong number of input agruments.")
  end
  if argn(2) < 4, x = []; end

  nz = max(length(a)-1,length(b)-1);
  zf=zeros(nz,1);

  
  if length(a)<(nz+1)
    a(length(a)+1:nz+1)=0;
  end
  if length(b)<(nz+1)
    b(length(b)+1:nz+1)=0;
  end
 
  if length(x) < nz
    x(length(x)+1:nz)=0;
  end
  if length(y) < nz
    y(length(y)+1:nz)=0;
  end

  for i=nz:-1:1
    for j=i:nz-1
      zf(j) = b(j+1)*x(i) - a(j+1)*y(i)+zf(j+1);
    end
    zf(nz)=b(nz+1)*x(i)-a(nz+1)*y(i);
  end

endfunction

