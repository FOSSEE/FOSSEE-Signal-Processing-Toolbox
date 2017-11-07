function y = vco(x,frange,fs)
//Voltage Controlled Oscillator
//Calling Sequence
//y=vco(x,fc,fs)
//y=vco(x,[fmin fmax],fs)
//Parameters
//x
//A vector or a matrix
//fc
//Carrier frequency
//fs
//fmin
//Minimum frequency of the frequency range
//fmax
//Maximum frequency of the frequency range
//Description
//y=vco(x,fc,fs)
//Creates a frequency modulated cosine wave y whose frequency varies as the magnitude of x
//x lies in [-1,1]. x=-1 corresponds to a frequency of 0, x=0 corresponds to a frequency of fc 
//and x=1 corresponds to a frequency of 2fc.
//y=vco(x,[fmin fmax],fs)
//Scales the frequency range so that x=-1 corresponds to a frequency of fmin and 
//x=1 corresponds to a frequency of fmax
//If x is a matrix the same operation is performed on the columns on x
//Size of y is the same as the size of x
//Example
//x=rand()
// x  =
// 
//    0.2113249  
// y=vco(x,2000,8000)
// y  =
// 
//    0.9454092 
//Author
//Ankur Mallick
    funcprot(0);
    if (argn(2)<3|argn(2)>5) then
        error('Incorrect number of input arguments.');
    else
        if(argn(2)<3)
            fs=1;
        end
        if(argn(2)<2)
            fc=fs/4;
            frange=fc;
        end
        if(max(abs(x(:)))>1)
            error('x must lie between -1 and 1');
        end
        if(length(frange)==1)
            fc = frange(1);
            opt = (fc/fs)*2*%pi;
        else
            fc = mean(frange);
            opt = (frange(2) - fc)/fs*2*%pi;
        end
        if (fc>fs/2)
            error('The career frequency must be less than half the sampling frequency.')
        else
            y = modulate(x,fc,fs,'fm',opt);
        end
    end
endfunction
