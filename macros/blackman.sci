function w=blackman(N,sflag)
//Generates a Blackman window
//Calling Sequence
//w=blackman(N)
//w=blackman(N,sflag)
//Parameters
//N
//A positive integer describing the length of the blackman window
//sflag
//Specifies the type of blackman window desired. Can be 'symmetric' or 'periodic'
//Description
//w=blackman(N) returns an N-point symmetric Blackman window in a column vector w
//w=blackman(N,sflag)
//Returns an N point Blackman window using the type of sampling specified by sflag
//sflag can be either 'symmetric' (default) or 'periodic' (used in spectral analysis)
//Example
//w=blackman(4)
//w  =
// 
//  - 1.388D-17  
//    0.63       
//    0.63       
//  - 1.388D-17  
//Author
//Ankur Mallick
//References
//[1] Oppenheim, Alan V., Ronald W. Schafer, and John R. Buck. Discrete-Time Signal Processing. Upper Saddle River, NJ: Prentice Hall, 1999.
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
