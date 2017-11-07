function y=udecode(u,n,v,saturatemode)
//Decodes the input uniformly quantized values
//Calling Sequence
//y=uencode(u,n,v,'saturatemode')
//Parameters
//u
//A vector, matrix or n-dimensional array of integers
//n
//An integer between 2 and 32
//v
//A positive real scalar 
//'saturatemode'
//A string which can take only 2 values 'saturate' or 'wrap'
//Description
//Uniformly decodes the input vector or n-dimensional array of integers u with peak values +/- v
//If u has only positive values, the range of integers is assumed to be [0,2^n-1]
//If u has positive and negative values the range of integers is assumed to be [-2^(n-1),2^(n-1)-1] 
//If v is not specified, its default value is 1
//If saturatemode='wrap' the output is wrapped using modulo arithmetic if overflow occurs
//If saturatemode='saturate' the output is saturated if overflow accors
//Example
//u = int8([-1 1 2 -5]);
//ysat = udecode(u,3)
//ysat  =
// 
//  - 0.25    0.25    0.5  - 1.  
//Author
//Ankur Mallick
//[1] International Telecommunication Union. General Aspects of Digital Transmission Systems: Vocabulary of Digital Transmission and Multiplexing, and Pulse Code Modulation (PCM) Terms. ITU-T Recommendation G.701. March, 1993.
//See also
//uencode
//floor
    funcprot(0);
    if(argn(2)<4)
        saturatemode='saturate';
        if(argn(2)<3)
            v=1;
        end
    end
    if(argn(2)>4|argn(2)<2)
        error('Incorrect number of input arguments.');
    elseif(saturatemode~='saturate'&saturatemode~='wrap')
        error('Saturate mode must be saturate or wrap');
    elseif(~isscalar(v)|abs(v)~=v)
        error('Peak value must be a positive real scalar');
    elseif(~isscalar(n)|round(n)~=n|n<2|n>32)
        error('n must be an integer between 2 and 32')
    elseif(type(u)~=8)
        error('Input value must be an integer');
    else
        if(inttype(u)==1|inttype(u)==2|inttype(u)==4)
            u=u+2^(n-1);   //Converting signed to unsigned
        end
        if(saturatemode=='wrap')
            u=pmodulo(double(u),2^n);
        end
        u(u<0)=0;
        u(u>(2^n-1))=2^n-1;
        L=2*v/(2^n);
        y=L*double(u)-v;
//        y(y<-v)=-v;
//        y(y>v)=v;
    end
endfunction
