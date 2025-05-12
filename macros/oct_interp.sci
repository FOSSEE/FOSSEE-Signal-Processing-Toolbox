// Copyright (C) 2000 Paul Kienzle <pkienzle@users.sf.net>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, see <http://www.gnu.org/licenses/>.

function y = oct_interp(x, q, varargin)
// This function upsamples the signal x by a factor of q, using an order 2*q*n+1 FIR filter.
//
//  Syntax
// y = interp(x, q)
// y = interp(x, q, n)
// y = interp(x, q, n, Wc)
//
// Parameters
// x: scalar or vector of complex or real numbers
// q: positive integer value, or logical
// n: positive integer, default value 4
// Wc: non decreasing vector or scalar, starting from 0 uptill 1, default value 0.5
//
// Description
// This function upsamples the signal x by a factor of q, using an order 2*q*n+1 FIR filter.
// The second argument q must be an integer. The default values of the third and fourth arguments (n, Wc) are 4 and 0.5 respectively.
//
// Examples
// interp(1,2)
// 

 funcprot(0);
    [nargout,nargin]=argn();

  if nargin < 1 | nargin > 4,
    error("Wrong Number of input arguments");
  end
  if q ~= fix(q), error("decimate only works with integer q."); end

  if(nargin>2)
      if(nargin==3)
        n=varargin(1);
        Wc=0.5;
      else
        n=varargin(1);
        Wc=varargin(2);
      end
  else
      n=4;Wc=0.5;
  end
  if size(x,1)>1
    y = zeros(length(x)*q+q*n+1,1);
  else
    y = zeros(1,length(x)*q+q*n+1);
  end
  y(1:q:length(x)*q) = x;
  b = fir1(2*q*n+1, Wc/q);
  y=q*fftfilt(b, y);
  y(1:q*n+1) = [];  // adjust for zero filter delay

endfunction
