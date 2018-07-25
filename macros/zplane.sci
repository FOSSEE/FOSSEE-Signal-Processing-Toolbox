//Pole-Zero plot for Discrete time systems

//Calling Sequence
//zplane(z)
//zpalne(z,p)

//Parameters:
//z: vector containing numerator coefficients
//p: vector containing denumerator coefficients

//Description:
//This function gives pole zero plote of discrete time systems

//Example :
//zplane([1 2 3],[4 5 6])
//Output :
//Output is pole zero plot of respective discrete time system.



//**************************************************************************************************
//______________________________________version1 code (not working)_________________________________
//__________________________________________________________________________________________________
//**************************************************************************************************

//function [y] = zplane(z,p)
//funcprot(0);
//
//rhs = argn(2)
//
//if(rhs<1 | rhs>2)
//error("Wrong number of input arguments.")
//end
//	select(rhs)
//	case 1 then
//	callOctave("zplane",z)
//	case 2 then
//	callOctave("zplane",z,p)
//	end
//endfunction

//**************************************************************************************************
//______________________________________________version2 code ( working)____________________________
//__________________________________________________________________________________________________
//**************************************************************************************************

function zplane(z,varargin)

    funcprot(0);

    [nargout nargin] = argn();
    if nargin == 1 then
        p = [];
    else
        p = varargin(1);
    end

[rows_z columns_z] = size(z);
[rows_p columns_p] = size(p);
  if (nargin < 1 | nargin > 2)
    error("Invalid inputs")
  end
  if columns_z>1 | columns_p>1
    if rows_z>1 | rows_p>1
//      ## matrix form: columns are already zeros/poles
    else
//      ## z -> b
//      ## p -> a
      if isempty(z), z=1; end
      if isempty(p), p=1; end

      M = length(z) - 1;
      N = length(p) - 1;
      z = [ roots(z); zeros(N - M, 1) ];
      p = [ roots(p); zeros(M - N, 1) ];
    end
  end


  xmin = min([-1; real(z(:)); real(p(:))]);
  xmax = max([ 1; real(z(:)); real(p(:))]);
  ymin = min([-1; imag(z(:)); imag(p(:))]);
  ymax = max([ 1; imag(z(:)); imag(p(:))]);
  xfluff = max([0.05*(xmax-xmin), (1.05*(ymax-ymin)-(xmax-xmin))/10]);
  yfluff = max([0.05*(ymax-ymin), (1.05*(xmax-xmin)-(ymax-ymin))/10]);
  xmin = xmin - xfluff;
  xmax = xmax + xfluff;
  ymin = ymin - yfluff;
  ymax = ymax + yfluff;

//  text();
//  plot_with_labels(z, "o");
//  plot_with_labels(p, "x");
//  refresh;

  r = exp(2*%i*%pi*[0:100]/100);
  plot(real(r), imag(r),'k'); //hold on;
//  axis equal;
//  grid on;
  xgrid ;
  mtlb_axis(1.05*[xmin, xmax, ymin, ymax]);
  if (~isempty(p))
    h = plot(real(p), imag(p), "bx");
    //set (h, 'MarkerSize', 7);
  end
  if (~isempty(z))
    h = plot(real(z), imag(z), "bo");
    //set (h, 'MarkerSize', 7);
  end
  legend('unit circle','poles','zeros');
//  hold off;

endfunction

//function plot_with_labels(x, symbol)
//
//    [rows_x columns_x] = size(x);
//
//  if ( ~isempty(x) )
//
//    x_u = unique(x(:));
//
//    for i = 1:length(x_u)
//      n = sum(x_u(i) == x(:));
//      if (n > 1)
//        xstring(real(x_u(i)), imag(x_u(i)), [" " msprintf('string', n)]);
//      end
//    end
//
//    col = "rgbcmy";
//    for c = 1:columns_x
//      plot(real( x(:,c) ), imag( x(:,c) ), [col(pmodulo(c,6)),symbol ";;"]);
//    end
//
//  end
//
//endfunction
