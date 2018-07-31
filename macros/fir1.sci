function b = fir1(n, w, varargin)

    funcprot(0);
    if argn(2) < 2 | argn(2) > 5
        error("Wrong Number of input arguments");
    end

    // Assign default window, filter type and scale.
    // If single band edge, the first band defaults to a pass band to
    // create a lowpass filter.  If multiple band edges, the first band
    // defaults to a stop band so that the two band case defaults to a
    // band pass filter.  Ick.

    window_in  = [];
    scale   = 1;
    ftype   = bool2s(length(w)==1);


    for i=1:length(varargin)
        arg = varargin(i);
        if (type(arg)==10)
            arg=convstr(arg,"l");
        end
        if isempty(arg)
            continue;
        end

        select arg
        case 'low' then ftype  = 1; case 'stop' then ftype  = 1; case 'dc-1' then ftype  = 1;
        case 'high' then ftype  = 0; case 'pass' then ftype  = 0; case 'bandpass' then ftype  = 0; case 'dc-0' then ftype  = 0;
        case 'scale' then scale=1;
        case 'noscale' then scale=0;
        else window_in=arg;
        end
    end

    // build response function according to fir2 requirements
    bands = length(w)+1;
    f = zeros(1,2*bands);
    f(2*bands)=1;
    f(2:2:2*bands-1) = w;
    f(3:2:2*bands-1) = w;
    m = zeros(1,2*bands);
    m(1:2:2*bands) = modulo([1:bands]-(1-ftype),2);
    m(2:2:2*bands) = m(1:2:2*bands);




    //Increment the order if the final band is a pass band.  Something
    // about having a nyquist frequency of zero causing problems.
    //
    if modulo(n,2)==1 & m(2*bands)==1,
        warning("n must be even for highpass and bandstop filters. Incrementing.");
        n = n+1;
        if isvector(window_in) & isreal(window_in) & ~(type(window_in)==10)
            // Extend the window using interpolation
            M = length(window_in);
            if M == 1,
                window_in = [window_in; window_in];
            elseif M < 4
                window_in = interp1(linspace(0,1,M),window_in,linspace(0,1,M+1),'linear');
            else
                window_in = interp1(linspace(0,1,M),window_in,linspace(0,1,M+1),'spline');
            end
        end
    end

    // compute the filter
    b = fir2(n, f, m, [], 2, window_in);

    // normalize filter magnitude
    if scale == 1
        // find the middle of the first band edge
        // find the frequency of the normalizing gain
        if m(1) == 1
            // if the first band is a passband, use DC gain
            w_o = 0;
        elseif f(4) == 1
            // for a highpass filter,
            // use the gain at half the sample frequency
            w_o = 1;
        else
            // otherwise, use the gain at the center
            // frequency of the first passband
            w_o = f(3) + (f(4)-f(3))/2;
        end

        // compute |h(w_o)|^-1

        if ~(isvector(b) | isempty(b))  // Check input is a vector
            error('Invalid');
        end

        x=exp(-1*%i*%pi*w_o)
//        z=[1 -exp(-1*%i*%pi*w_o)];
        nc = length(b);
       if(isscalar(x) &  nc>0 & (x~=%inf) & or(b(:)~=%inf))
            // Make it scream for scalar x.  Polynomial evaluation can be
            // implemented as a recursive digital filter.
            q=b;
            k = filter(1,[1 -real(x)],q);
            k=k(nc);
        end
        k=abs(k);
        renorm = 1/k


    // normalize the filter
    b = renorm*b;
end

endfunction
