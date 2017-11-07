function [y,t]=modulate(x,fc,fs,method,opt)
//Modulates signal according to the modulation method
//Calling Sequence
//y=modulate(x,fc,fs,method,opt)
//[y,t]=modulate(x,fc,fs,method,opt)
//Parameters
//x
//A vector or a matrix
//fc
//Carrier frequency
//fs
//Sampling frequency
//method
//Modulation Method
//opt
//An optional parameter required by certain modulation methods
//Description
//[y,t]=modulate(x,fc,fs,method,opt)
//Returns the modulated vector y and the time vector 't'
//Modulation is performed according to the following table
//   METHOD              MODULATION SCHEME
//    'am',      Amplitude modulation, double side-band, suppressed carrier
//    'amdsb-sc' opt not used. This is the default method.
//    'amdsb-tc' Amplitude modulation, double side-band, transmitted carrier
//               opt is a scalar subtracted from x before multiplying x 
//               with the carrier wave.  It defaults to min(min(x)) so that
//               the input signal after offset is always non-negative
//    'amssb'    Amplitude modulation, single side-band
//               OPT not used.
//    'fm'       Frequency modulation
//               opt is the constant of frequency modulation.
//               opt = (fc/fs)*2*pi/max(max(abs(x))) by default
//    'pm'       Phase modulation
//               OPT is the constant of phase modulation. 
//               opt = pi/max(max(abs(x))) by default 
//               Phase lies between -pi and +pi
//    'pwm'      Pulse width modulation
//               opt='left' corresponds to left justified pulses.
//               opt='centered' correspondes to centered pulses.
//               The default value of opt is 'left'.
//    'ppm'      Pulse position modulation
//               opt is a scalar between 0 and 1 which specifies the pulse 
//               width in fractions of the carrier period with default value 0.1.
//   'qam'       Quadrature amplitude modulation
//               opt is a matrix of the same size as X which is modulated in 
//               quadrature with x.
//
//   If x is a matrix, its columns are modulated.
//Example
//y  =
// 
//    1.    1.    0.    0.  
//Author
//Ankur Mallick
    funcprot(0);
    if (argn(2)<3|argn(2)>5) then
        error('Incorrect number of input arguments.');
    elseif (isreal(fc)&isreal(fs)&fc>fs/2)
        error('The career frequency must be less than half the sampling frequency.')
    else
        flag1=0;
        flag2=0;
        if (argn(2)<4)
            method='am';
        end
        [M,N]=size(x);
        if(M==1)
            flag1=1;
            x=x(:);
            [M,N]=size(x);
        end
        t=((0:M-1)/fs)';
        t=t*ones(1,N);
        if(method=='am'|method=='amdsb-sc')
            y=x.*cos(2*%pi*fc*t);
        elseif(method=='amdsb-tc')
            if(argn(2)<5)
                opt=min(min(x));
            end
            y=(x-opt).*cos(2*%pi*fc*t);
        elseif(method=='amssb')
            y=x.*cos(2*%pi*fc*t)+imag(hilbert(x)).*sin(2*%pi*fc*t);
        elseif(method=='fm')
            if(argn(2)<5)
                opt=max(abs(x(:))); //if all elements of x are zero
                if(opt>0)
                    opt=(fc/fs)*2*%pi/opt;
                end
            end
            y=cos(2*%pi*fc*t + opt*cumsum(x,1));
        elseif(method=='pm')
            if(argn(2)<5)
                opt=%pi/(max(abs(x(:))));
            end
            y=cos(2*%pi*fc*t + opt*x);
        elseif(method=='qam')
            if(argn(2)<5)
                error('For qam, a 5th input parameter is required.')
            else
                if(size(opt,1)==1)
                    opt=opt(:);
                end
                S=sum(abs(size(opt)-size(x))); //S=0 only if opt and x have the same size
                if(S==0)
                    y = x.*cos(2*%pi*fc*t) + opt.*sin(2*%pi*fc*t)
                else
                    error('For qam input signals must be the same size') 
                end
            end
        elseif(method=='pwm')
            if(argn(2)<5)
                opt='left'
            end
            if(max(x(:))>1|min(x(:))<0)
                error('x must lie between 0 and 1');
            else
                t=(0:(M*fs/fc-1))';
                t=t*ones(1,N);
                T=fs/fc;
                y=zeros(t);
                if(opt~='left'&opt~='centered')
                    error('5th input parameter not recognized');
                else
                    if(opt=='left')
                        compar=(pmodulo(t,T))/T;
                        pos=floor(t/T)+1;
                    elseif(opt=='centered')
                        compar1=2*pmodulo(t,T)/T;
                        compar=min(compar1,2-compar1);
                        x(M+1,:)=zeros(1,N);
                        pos=floor(t/T)+1;
                        r1=ceil(T/2);
                        r2=floor(T/2);
                        pos=[pos(r1+1:length(pos));(M+1)*ones(r2,1)];
                    end
                    for i=1:N
                        //x1=matrix(ones(T,1)*x(:,i)',size(t,1),1);
                        x1=x(pos,i)
                        y(compar<x1,i)=1;
                    end 
                end
            end
        elseif(method=='ppm'|method=='ptm')
            if(argn(2)<5)
                opt=0.1
            end
            t=(0:(M*fs/fc-1))';
            t=t*ones(1,N);
            T=fs/fc;
            y=zeros(t);
            if(max(x(:))>1|min(x(:))<0)
                error('x must lie between 0 and 1');
            elseif(~isscalar(opt)|opt<0|opt>1)
                error('opt must be a scalar between 0 and 1')
            else
                if (max(x) > 1-opt)
                    warning('Overlapping pulses')
                end
                for i=1:N
                    x1=x(:,i)'
                    start=1+ceil((x1+(0:M-1))*T); //y(1) corresponds to t=0
                    L=floor(opt*T);  
                    v=(0:1:L-1)';
                    p1=matrix(ones(L,1)*start,1,M*L)
                    p2=matrix(v*ones(1,M),1,M*L);
                    pos=p1+p2;
                    y(pos,i)=1;
                end
                y(length(t)+1:length(y),:)=[]; //Truncating vector
            end
        else
            error('Method not recognised');
            flag2=1;
        end
        if(flag2==0)
            t=t(:,1); //only first column required
            if(flag1==1)
                //x is a row vector
                y=conj(y');
                t=t';
            end
        end
    end
endfunction
