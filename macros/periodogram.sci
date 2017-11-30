function [d,n]=periodogram(a,b,c,d,e)
//Return the periodogram (Power Spectral Density) of X
//Calling Sequence
// [PXX, W] = periodogram (X)
// [PXX, W] = periodogram (X, WIN)
// [PXX, W] = periodogram (X, WIN, NFFT)
// [PXX, W] = periodogram (X, WIN, NFFT, FS)
// [PXX, W] = periodogram (..., "RANGE")
//Parameters 
// X:data vector.  If X is real-valued a one-sided spectrum is estimated. If X is complex-valued, or "RANGE" specifies "twosided", the full spectrum is estimated.
//WIN: window weight data.  If window is empty or unspecified a default rectangular window is used.  Otherwise, the window is applied to the signal ('X .* WIN') before computing th periodogram.  The window data must be a vector of the same length as X.
//NFFT:number of frequency bins.  The default is 256 or the next higher power of 2 greater than the length of X ('max (256,2.^nextpow2 (length (x)))').  If NFFT is greater than the length of the input then X will be zero-padded to the length of NFFT.
//FS:sampling rate.  The default is 1.
//RANGE:range of spectrum.  "onesided" computes spectrum from [0..nfft/2+1]."twosided" computes spectrum from [0..nfft-1].
//Description
//The optional second output W are the normalized angular frequencies.  For a one-sided calculation W is in the range [0, pi]. If NFFT is even and [0, pi) if NFFT is odd.  Similarly, for a two-sided calculation W is in the range [0, 2*pi] or [0, 2*pi)depending on NFFT.
//
//If a sampling frequency is specified, FS, then the output frequencies F will be in the range [0, FS/2] or [0, FS/2) for one-sided calculations. For two-sided calculations the range will be [0, FS).
//
//When called with no outputs the periodogram is immediately plotted in the current figure window.
    funcprot(0);
    lhs= argn(1);
    rhs= argn(2);
    if(rhs<1 | rhs>5)
        error("Wrong number of input arguments");
    end
    if(lhs>2 | lhs< 2)
        error("Wrong number of output arguments");
    end
    select(rhs)
    case 1 then
            [d,n]= callOctave('periodogram',a);
    case 2 then
            [d,n]= callOctave('periodogram',a,b);

    case 3 then
            [d,n]= callOctave('periodogram',a,b,c);

    case 4 then
            [d,n]= callOctave('periodogram',a,b,c,d);
  
    case 5 then
            [d,n]= callOctave('periodogram',a,b,c,d,e);
    end
endfunction

