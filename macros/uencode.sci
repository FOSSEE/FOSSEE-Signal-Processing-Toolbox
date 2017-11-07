function y=uencode(u,n,v,signflag)
    //Performs uniform quantization of the input into 2^n levels
    //Calling Sequence
    //y=uencode(u,n,v,'signflag')
    //Parameters
    //u
    //A vector, matrix or n-dimensional array
    //n
    //An integer between 2 and 32
    //v
    //A positive real scalar 
    //'signflag'
    //A string which can take only 2 values 'signed' or 'unsigned'
    //Description
    //Uniformly quantizes the input vector or n-dimensional array u into 2^n levels in the interval [-v,v]
    //If v is not specified, its default value is 1
    //'signflag' is a string that determines the nature of the quantization
    //If signflag='unsigned' then y contains unsigned integers in the range [0,2^n-1] corresponding to the 2^n levels
    //If signflag='unsigned' then y contains signed integers in the range [-2^(n-1),2^(n-1)-1] corresponding to the 2^n levels
    //The  size of the integers in y in bits(8,16, or 32) depends on the value of n
    //If the input lies beyond +/- v it is saturated
    //Example
    //y=uencode(-1:0.5:1,3)
    // y  =
    // 
    //  0  2  4  6  7 
    //Author
    //Ankur Mallick
    //References
    //[1] International Telecommunication Union. General Aspects of Digital Transmission Systems: Vocabulary of Digital Transmission and Multiplexing, and Pulse Code Modulation (PCM) Terms. ITU-T Recommendation G.701. March, 1993.
    //See also
    //udecode
    //floor
    funcprot(0);
    if(argn(2)<4)
        signflag='unsigned';
        if(argn(2)<3)
            v=1;
        end
    end
    if(argn(2)>4|argn(2)<2)
        error('Incorrect number of input arguments.');
    elseif(signflag~='signed'&signflag~='unsigned')
        error('Sign flag must be signed or unsigned');
    elseif(~isscalar(v)|abs(v)~=v)
        error('Peak value must be a positive real scalar');
    elseif(~isscalar(n)|round(n)~=n|n<2|n>32)
        error('n must be an integer between 2 and 32')
    else
        if(or(imag(u(:))~=0))
            //Complex Number
            u_real=real(u);
            y_real=uencode(u_real,n,v,signflag);
            disp(type(y_real));
            u_imag=imag(u);
            y_imag=uencode(u_imag,n,v,signflag);
            y=double(y_real)+%i*double(y_imag);
           else
            //Real Numbers
            y=zeros(u);
            L=2*v/(2^n);
            y=floor((u+v)/L);
            y(y<0)=0;
            y(y>(2^n-1))=2^n-1;
            if(signflag=='signed')
                y=y-2^(n-1);
                if(n>=2&n<=8)
                    y=int8(y);
                elseif(n>=9&n<=16)
                    y=int16(y);
                else
                    y=int32(y);
                end
            else
                if(n>=2&n<=8)
                    y=uint8(y);
                elseif(n>=9&n<=16)
                    y=uint16(y);
                else
                    y=uint32(y);
                end
            end
        end
    end
endfunction
