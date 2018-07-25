// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:[insert name]
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function  r  = zerocrossing (x,y)

//This function estimates the points at which a given waveform crosses the x-axis.
//Estimates the points at which a given waveform y=y(x) crosses the
//x-axis using linear interpolation.
//Calling Sequence
//r = zerocrossing (w, y)
//Parameters
//r: zero crossing points
//y:function y=y(x)...the dependant variable
//x:the independant variable
//Description
//This function estimates the points at which a given waveform y = y(w) crosses the x-axis. It uses linear interpolation.
//Examples
////1.
//x = linspace(0,1,100);
// y = rand(1,100)-0.5;
// x0= zerocrossing(x,y);
//y0=interp1(x,y,x0)
//plot(x,y,x0,y0,'x')

//
////////2.
//x = linspace(0,1,100);
// y = 2*sin(2*%pi*x);
// x0= zerocrossing(x,y);
//ans:
//// x0  =  0.    0.5
//y0=interp1(x,y,x0)
//plot(x,y,x0,y0,'x')
//


  x = x(:);y = y(:);
  crossing_intervals = (y(1:$-1).*y(2:$ )<= 0);//find for crossing intervals

  left_ends = (x(1:$-1)).*(crossing_intervals);
  right_ends = (x(2:$)).*(crossing_intervals);

  left_vals = (y(1:$-1)).*(crossing_intervals);
  right_vals = (y(2:$)).*(crossing_intervals);
  mid_points = (left_ends+right_ends)./2;//finding the midpoints of crossing interval

  zero_intervals = find(left_vals==right_vals);

  retval1 = mid_points(zero_intervals);//finding the set of points where the function crosses the x-axis

  left_ends(zero_intervals) = [];
  right_ends(zero_intervals) = [];
  left_vals(zero_intervals) = [];
  right_vals(zero_intervals) = [];
  retval2=left_ends-(right_ends-left_ends).*left_vals./(right_vals-left_vals);
  r = union(retval1,retval2);//combining both retval1 and retval2 and removing redundancies

endfunction
