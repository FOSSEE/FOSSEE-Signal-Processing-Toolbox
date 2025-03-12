// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Date of Modification: 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [zero, pole, gain]=besselap(n)
    //Bessel analog filter prototype.

    //Calling Sequence
    //[zero, pole, gain] = besselap(n)
    //zero = besselap(n)

    //Parameters
    //n: Filter Order
    //zero: Zeros
    //pole: Poles
    //gain: Gain

    //Description
    //It Return bessel analog filter prototype of nth order.

    //Examples
    //[zero, pole, gain] = besselap (5)
    //Output :
    // gain  =
    //
    //    1.
    // pole  =
    //
    //  - 0.5905759 + 0.9072068i
    //  - 0.5905759 - 0.9072068i
    //  - 0.9264421
    //  - 0.8515536 + 0.4427175i
    //  - 0.8515536 - 0.4427175i
    // zero  =
    //
    //     []
    // Dependencies
    // prepad


    funcprot(0);
    [nargout, nargin] = argn() ;
    if (nargin>1 | nargin<1)
        error("besselap : wrong number of input argument")
    end
    // interpret the input parameters
    if (~(length(n)==1 & n == round(n) & n > 0))
        error ("besselap: filter order n must be a positive integer");
    end
    p0=1;
    p1=[1 1];
    for nn=2:n
        px=(2*nn-1)*p1;
        py=[p0 0 0];
        px=prepad(px,max(length(px),length(py)));
        py=prepad(py,length(px));
        p0=p1;
        p1=px+py;
    end
    // p1 now contains the reverse bessel polynomial for n
    // scale it by replacing s->s/w0 so that the gain becomes 1
    p1=p1.*p1(length(p1)).^((length(p1)-1:-1:0)/(length(p1)-1));
    zero=[];
    pole=roots(p1);
    gain=1;
endfunction

/* 
Note : The function is tested with Octave's outputs as a reference.
# all passed 
[zero, pole, gain] = besselap (1) 
[zero, pole, gain] = besselap (2)
[zero, pole, gain] = besselap (7)
[zero, pole, gain] = besselap (13)
[zero, pole, gain] = besselap (43)    

*/