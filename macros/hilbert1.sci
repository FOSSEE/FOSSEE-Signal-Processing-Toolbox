/*Calling Sequence
          h = hilbert1 (f)  
          h = hilbert1 (f, N)
          h = hilbert1 (f, N, dim)
Description
          Analytic extension of real valued signal.
          h = hilbert (f) computes the extension of the real valued signal f to an analytic signal.
          If f is a matrix, the transformation is applied to each column.
          For N-D arrays, the transformation is applied to the first non-singleton dimension.
          real (h) contains the original signal f. imag (h) contains the Hilbert transform of f.
          hilbert (f, N) does the same using a length N Hilbert transform. The result will also have length N.
          hilbert (f, [], dim) or hilbert (f, N, dim) does the same along dimension dim.
Dependencies
          fft1, ifft1, ipermute
Example
            //the magnitude of the hilbert transform eliminates the carrier
            t=linspace(0,10,1024);
            x=5*cos(0.2*t).*sin(100*t);
            plot(t,x,t,abs(hilbert(x)));
          */
function f=hilbert1(f, N ,dim )
  // ------ PRE: initialization and dimension shifting ---------
  nargin = argn(2); 
  if (nargin<1 || nargin>3)
    error("Please enter valid number of inputs")
  end
  if ~isreal(f)
    warning ('HILBERT: ignoring imaginary part of signal');
    f = real (f);
  end
  D=ndims(f);
  select nargin
  case 1 then
    N=[];
    dim=[];
  case 2 then
    dim=[]
  end
  // Dummy assignment.
  order=1;
  if isempty(dim)
    dim=1;
    if sum(size(f)>1)==1
      // We have a vector, find the dimension where it lives.
      dim=find(size(f)>1);
    end
  else
    if (length(dim)~=1 || ~or(type(dim)==[1 5 8]))
      error('HILBERT: dim must be a scalar.');
    end
    if modulo(dim,1)~=0
      error('HILBERT: dim must be an integer.');
    end
    if (dim<1) || (dim>D)
      error('HILBERT: dim must be in the range from 1 to %d.',D);
    end
  end
  if (length(N)>1 || ~or(type(N)==[1 5 8]))
    error('N must be a scalar.');
  elseif (~isempty(N) && modulo(N,1)~=0)
    error('N must be an integer.');
  end
  if dim>1
    order=[dim, 1:dim-1,dim+1:D];
    // Put the desired dimension first.
    f=permute(f,order);
  end
  Ls=size(f,1);
  // If N is empty it is set to be the length of the transform.
  if isempty(N)
    N=Ls;
  end
  // moduloember the exact size for later and modify it for the new length
  permutedsize=size(f);
  permutedsize(1)=N;
  // Reshape f to a matrix.
  f=resize_matrix(f,size(f,1),length(f)/size(f,1));
  W=size(f,2);
  if ~isempty(N)
    siz=size(f);
    siz(1)=N;
    f=resize_matrix(f,siz);
  end
  // ------- actual computation -----------------
  if N>2
    f=fft1(f);
    if modulo(N,2)==0
      f=[f(1,:);
         2*f(2:N/2,:);
         f(N/2+1,:);
         zeros(N/2-1,W)];
    else
      f=[f(1,:);
         2*f(2:(N+1)/2,:);
         zeros((N-1)/2,W)];
    end
    f=ifft1(f);
  end
  // ------- POST: Restoration of dimensions ------------
  // Restore the original, permuted shape.
  f=matrix(f,permutedsize);
  if dim>1
    // Undo the permutation.
    f=ipermute(f,order);
  end
endfunction
