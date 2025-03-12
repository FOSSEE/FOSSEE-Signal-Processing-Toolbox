// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
/*
  : [B,A] = invfreq(H,F,nB,nA,W)
  : [B,A] = invfreq(H,F,nB,nA,W,[],[],plane) 
  : [B,A] = invfreq(H,F,nB,nA,W,iter,tol,plane) 

    Fit filter B(z)/A(z) or B(s)/A(s) to complex frequency response at frequency points F.

    A and B are real polynomial coefficients of order nA and nB respectively. Optionally, the fit-errors can be weighted vs frequency according to the weights W. Also, the transform plane can be specified as either ’s’ for continuous time or ’z’ for discrete time. ’z’ is chosen by default. Eventually, Steiglitz-McBride iterations will be specified by iter and tol.

    H: desired complex frequency response It is assumed that A and B are real polynomials, hence H is one-sided.

    F: vector of frequency samples in radians

    nA: order of denominator polynomial A

    nB: order of numerator polynomial B

    plane=’z’: F on unit circle (discrete-time spectra, z-plane design)

    plane=’s’: F on jw axis (continuous-time spectra, s-plane design)

    H(k) = spectral samples of filter frequency response at points zk, where zk=exp(sqrt(-1)*F(k)) when plane=’z’ (F(k) in [0,.5]) and zk=(sqrt(-1)*F(k)) when plane=’s’ (F(k) nonnegative)
*/
// FIXME: implement Steiglitz-McBride iterations
// FIXME: improve numerical stability for high order filters (matlab is a bit better)
// FIXME: modify to accept more argument configurations
function [B, A, SigN] = invfreq(H, F, nB, nA, W, iter, tol, tr, plane,varargin)

  if nargin < 4  then 
    error("invfreq : Incorrect number of input arguments ")
  end

  if ~isvector(H) && ~isscalar(H) then 
    error("invfreq : H is the desired frequency response , a vector expected")
  end

  if ~isvector(F) && ~isscalar(F) then 
    error("invfreq : F is a vector of frequency samples in radians")
  end

  if max(size(nB)) > 1 then zB = nB(2); nB = nB(1); else zB = 0; end
  n = max(nA, nB);
  m = n+1; mA = nA+1; mB = nB+1;
  nF = max(size(F));
  if nargin < 5 || isempty(W) then W = ones(1, nF); end
  if nargin < 6 then iter = []; end
  if nargin < 7  then tol = []; end
  if nargin < 8 || isempty(tr) then  tr = ''; end
  if nargin < 9 then plane = 'z'; end
  if nargin < 10 then varargin = {}; end
  if ( strcmp (plane, "s") &&  strcmp (plane, "z"))
    error (sprintf("invfreq: invealid PLANE argument %s, expected  s  or  z ", plane))
  end

  fname = ["invfreq", plane];

  if (nF ~= max(size(H))) then
    error ("%s: Length of H and F must be the same\n", fname)
  end

  if (~ isempty (iter) || ~ isempty (tol)) then
    warning (sprintf("%s: iterative algorithm not yet implemented, ", ...
              "ITER and TOL arguments are ignored\n", fname));
  end

//////////////////////////////////////////////////////////////
norm = %f ; // should we normalize freqs to avoid matrices with rank deficiency ?
method = 'LS'; // by default, use Ordinary Least Square to solve normal equations
prop = varargin;
if length(prop) > 0 then 
  indi = 1;
  while indi < length(prop)
      switch prop(indi)
          case 'norm'
              if indi < length(prop) && ~(type(prop(indi+1)) == 10)
                  norm = prop(indi+1);
                  indi = indi + 2; // Skip the processed element
              else
                  norm = %t; // Default true
                  indi = indi + 1;
              end
              
          case 'method'
              if indi < length(prop) && type(prop(indi+1)) == 10 && strcmp(prop(indi+1), "norm")
                  method = prop(indi+1);
                  indi = indi + 2; // Skip the processed element
              else
                  error("invfreq : incorrect/missing method argument");
                  indi = indi + 1;
              end
              
          otherwise
              disp("Ignoring unknown or incomplete argument");
              indi = indi + 1;
      end
  end
end


////////////////////////////////////////////////////////////////


  Ruu = zeros(mB, mB); Ryy = zeros(nA, nA); Ryu = zeros(nA, mB);
  Pu = zeros(mB, 1);   Py = zeros(nA,1);
  if ~strcmp(tr,'trace')
    disp(' ')
    disp('Computing nonuniformly sampled, equation-error, rational filter.');
    disp(['plane = ',plane]);
    disp(' ')
  end

  s = sqrt(-1)*F;
  switch plane
    case 'z' 
      if max(F) > %pi || min(F) < 0 then
        disp('hey, you frequency is outside the range 0 to %pi, making my own')
        F = linspace(0, %pi, max(size(H)));
        s = sqrt(-1)*F;
      end
      s = exp(-s);
    case 's'
      if max(F) > 1e6 && n > 5 then 
        if ~norm then 
          disp('Be careful, there are risks of generating singular matrices');
          disp('Call invfreqs as (..., norm, 1) to avoid it');
        else
          Fmax = max(F); s = sqrt(-1)*F/Fmax;
        end
      end
  end

  //////////////////////////////
  /////////////////////////////
  for k=1:nF,
    Zk = (s(k).^[0:n]).';
    Hk = H(k);
    aHks = Hk*conj(Hk);
    Rk = (W(k)*Zk)*Zk';
    rRk = real(Rk);
    Ruu = clean(Ruu + rRk(1:mB, 1:mB));
    Ryy = Ryy + aHks*rRk(2:mA, 2:mA);
    Ryu = Ryu + real(Hk*Rk(2:mA, 1:mB));
    Pu = Pu + W(k)*real(conj(Hk)*Zk(1:mB));
    Py = Py + (W(k)*aHks)*real(Zk(2:mA));
  end
  Rr = ones(max(size(s)), mB+nA); Zk = s;
  for k = 1:min(nA, nB),
    Rr(:, 1+k) = Zk;
    Rr(:, mB+k) = -Zk.*H;
    Zk = Zk.*s;
  end
  for k = 1+min(nA, nB):max(nA, nB)-1,
    if k <= nB, Rr(:, 1+k) = Zk; end
    if k <= nA, Rr(:, mB+k) = -Zk.*H; end
    Zk = Zk.*s;
  end
  k = k+1;
  if k <= nB then Rr(:, 1+k) = Zk; end
  if k <= nA then Rr(:, mB+k) = -Zk.*H; end

  // complex to real equation system -- this ensures real solution
  Rr = Rr(:, 1+zB:$);
  Rr = [real(Rr); imag(Rr)]; Pr = [real(H(:)); imag(H(:))];
  // normal equations -- keep for ref
  // Rn= [Ruu(1+zB:mB, 1+zB:mB), -Ryu(:, 1+zB:mB)';  -Ryu(:, 1+zB:mB), Ryy];
  // Pn= [Pu(1+zB:mB); -Py];
  ////////////////////////////////////////////////
  switch method
    case {'ls' 'LS'}
      // avoid scaling errors with Theta = R\P;
      // [Q, R] = qr([Rn Pn]); Theta = R(1:$, 1:$-1)\R(1:$, $);
      [Q, R] = qr([Rr Pr]); Theta = pinv(R(1:$-1, 1:$-1)) * R(1:$-1, $);
      //////////////////////////////////////////////////
      // SigN = R($, $-1);
      SigN = R($, $);
    case {'tls' 'TLS'}
      // [U, S, V] = svd([Rn Pn]);
      // SigN = S($, $-1);
      // Theta =  -V(1:$-1, $)/V($, $);
      [U, S, V] = svd([Rr Pr], 0);
      SigN = S($, $);
      Theta =  -V(1:$-1, $)/V($, $);
    case {'mls' 'MLS' 'qr' 'QR'}
      // [Q, R] = qr([Rn Pn], 0);
      // solve the noised part -- DO NOT USE ECONOMY SIZE ~
      // [U, S, V] = svd(R(nA+1:$, nA+1:$));
      // SigN = S($, $-1);
      // Theta = -V(1:$-1, $)/V($, $);
      // unnoised part -- remove B contribution and back-substitute
      // Theta = [R(1:nA, 1:nA)\(R(1:nA, $) - R(1:nA, nA+1:$-1)*Theta)
      //         Theta];
      // solve the noised part -- economy size OK as #rows > #columns
      [Q, R] = qr([Rr Pr], 0);
      eB = mB-zB; sA = eB+1;
      [U, S, V] = svd(R(sA:$, sA:$));
      // noised (A) coefficients
      Theta = -V(1:$-1, $)/V($, $);
      // unnoised (B) part -- remove A contribution and back-substitute
      Theta = [R(1:eB, 1:eB)\(R(1:eB, $) - R(1:eB, sA:$-1)*Theta)
               Theta];
      SigN = S($, $);
    otherwise
      error(sprintf("invfreq : unknown method %s", method));
  end

  B = [zeros(zB, 1); Theta(1:mB-zB)].';
  A = [1; Theta(mB-zB+(1:nA))].';
  if ~strcmp(plane,'s')
    B = B(mB:-1:1);
    A = A(mA:-1:1);
    if norm, // Frequencies were normalized -- unscale coefficients
      Zk = Fmax.^[n:-1:0].';
      for k = nB:-1:1+zB, B(k) = B(k)/Zk(k); end
      for k = nA:-1:1, A(k) = A(k)/Zk(k); end
    end
  end
endfunction

/*
// method - LS
test case 1 // passed

[B,A,Sign] = invfreq(1,1,1,1,1,[],[],'','z','norm',1,'method','LS')
assert_checkequal(B,[0.6314 0.3411])
assert_checkequal(A,[1 -0.3411])
assert_checkequal(Sign,0)

[B,A,Sign] = invfreq(1,1,1,1,1,[],[],'','s')
assert_checkequal(B,[0 1])
assert_checkequal(A,[0 1])
assert_checkequal(Sign,0)


test case 2 // passed 
order = 6 
fc = 1/2 
n = 128 
B = [    0.029588   0.177529   0.443823   0.591764   0.443823   0.177529   0.029588] ;
A = [ 1.0000e+00  -6.6613e-16   7.7770e-01  -2.8192e-16   1.1420e-01  -1.4472e-17   1.7509e-03];
[H,w] = freqz(B,A,n) ; 
[Bh , Ah] = invfreq(H,w,order,order);
[Hh,wh] = freqz(Bh,Ah,n);
plot(w,[abs(H), abs(Hh)])
xlabel("Frequency (rad/sample)");
ylabel("Magnitude");
legend('Original','Measured');
err = norm(H-Hh);
disp(sprintf('L2 norm of frequency response error = %f',err));

test case 3 // passed 
// buttter worth filter of order 12 and fc=1/4
B = [ 1.1318e-06   1.3582e-05   7.4702e-05   2.4901e-04   5.6026e-04   8.9642e-04   1.0458e-03   8.9642e-04 5.6026e-04   2.4901e-04   7.4702e-05   1.3582e-05   1.1318e-06];
A = [ 1.0000e+00  -5.9891e+00   1.7337e+01  -3.1687e+01   4.0439e+01  -3.7776e+01   2.6390e+01  -1.3851e+01  5.4089e+00  -1.5296e+00   2.9688e-01  -3.5459e-02   1.9688e-03];
[H,w] = freqz(B,A,128);
[Bh,Ah] = invfreq(H,w,4,4);
[Hh,wh] = freqz(Bh,Ah,128);
disp(sprintf('||frequency response error||= %f',norm(H-Hh)));


method TLS 

test case 1 // passed

B = [ 1.1318e-06   1.3582e-05   7.4702e-05   2.4901e-04   5.6026e-04   8.9642e-04   1.0458e-03   8.9642e-04 5.6026e-04   2.4901e-04   7.4702e-05   1.3582e-05   1.1318e-06];
A = [ 1.0000e+00  -5.9891e+00   1.7337e+01  -3.1687e+01   4.0439e+01  -3.7776e+01   2.6390e+01  -1.3851e+01  5.4089e+00  -1.5296e+00   2.9688e-01  -3.5459e-02   1.9688e-03];
[H,w] = freqz(B,A,128);
[Bh,Ah] = invfreq(H,w,4,4,[],[],[],'','z','norm',1,'method','TLS');
[Hh,wh] = freqz(Bh,Ah,128);
disp(sprintf('||frequency response error||= %f',norm(H-Hh)));




method MLS - passed 


// elliptic filter with  ellip (5, 1, 90, [.1 .2])
n = 128 
B = [ 1.3214e-04  -6.6404e-04   1.4928e-03  -1.9628e-03   1.4428e-03  0  -1.4428e-03   1.9628e-03 -1.4928e-03   6.6404e-04  -1.3214e-04] ;
A = [ 1.0000    -8.6483    34.6032   -84.2155   137.9276  -158.7598   130.0425   -74.8636    29.0044    -6.8359  0.7456];
[H,w] = freqz(B,A,n) ; 

[Bh,Ah] = invfreq(H,w,4,4,[],[],[],'','z','norm',1,'method','MLS');
[Hh,wh] = freqz(Bh,Ah,n);
plot(w,[abs(H), abs(Hh)])
xlabel("Frequency (rad/sample)");
ylabel("Magnitude");
legend('Original','Measured');
err = norm(H-Hh);
disp(sprintf('L2 norm of frequency response error = %f',err));


*/
