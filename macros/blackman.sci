function w = blackman(N, sflag)
// Generate a Blackman window.
//
// Syntax
//   w = blackman(N)
//   w = blackman(N, sflag)
//
// Parameters
// N: Positive integer. Length of the Blackman window.
// sflag: String. Specifies the type of Blackman window ('symmetric' or 'periodic'). Default is 'symmetric'.
//
// Description
// This function generates an N-point Blackman window. By default, it returns a symmetric Blackman window. If `sflag` is set to 'periodic', the function generates a periodic Blackman window, which is useful in spectral analysis.
//
// Examples
// w = blackman(4)
// w =
//  -1.388D-17
//   0.63
//   0.63
//  -1.388D-17
//
// Authors
// Ankur Mallick
//
// Bibliography
// [1] Oppenheim, Alan V., Ronald W. Schafer, and John R. Buck. Discrete-Time Signal Processing. Upper Saddle River, NJ: Prentice Hall, 1999.

    funcprot(0);
    if(argn(2)<2)
        sflag='symmetric'; //Default
    end
    if(argn(2)<1|argn(2)>2)
        error('Incorrect number of input arguments.');
    elseif(~isscalar(N)|N<=0|round(N)~=N)
        error('N must be a positive integer')
    elseif(sflag~='symmetric'&sflag~='periodic')
        error('Sampling flag must be either symmetric or periodic');
    elseif(N==1)
        w=1; //Trivial case
    else
        flag=0;
        if(sflag=='periodic')
            N=N+1;
            flag=1;
        end
        if(pmodulo(N,2)==1)
            M=(N+1)/2; //odd
        else
            M=N/2; //even
        end
        n=0:1:M-1;
        w1=0.42-0.5*cos(2*%pi*n/(N-1))+0.08*cos(4*%pi*n/(N-1));
        p=2*M-N; //0 for N even, 1 for N odd
        w=[w1, w1(M-p:-1:1)]';
        if(flag==1)
            //Periodic case
            w(N)=[];
        end
    end
endfunction
