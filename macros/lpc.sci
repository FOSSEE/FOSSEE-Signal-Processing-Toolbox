function [a,g] = lpc(x,varargin)
    // Linear prediction filter coefficients
    //
    //
    // Calling Sequence
    // [a,g] = lpc(x)
    // [a,g] = lpc(x,p)
    //
    //
    // Description
    // [a,g] = lpc(x,p)
    //      Determines the coefficients of a pth order forward linear predictor 
    //      filter by minimizing the squared error. If p is unspecified, a 
    //      default value of length(x)-1 is used.
    //
    // Parameters
    // x: double
    //      The input signal. If x is a matrix, each column in treated as an 
    //      independent computation
    // p: int, natural number, scalar
    //      The order of the linear prediction filter to be inferred. Value must
    //      be a scalar and a positive natural number. p must be less than or 
    //      equal to the length of the signal vector
    // a: double
    //      The coefficients of the forward linear predictor. Coefficient for 
    //      each signal input is returned as a row vector.
    // g: double
    //      Column vector of averaged square prediction error
    //
    //
    // Examples
    // 1) 
    //      noise = randn(20000,1);
    //      x = filter(1,[1 1/5 1/3 1/4],noise);
    //      x = x(15904:20000);
    //      [a,g] = lpc(x,3);
    //
    //
    // References
    // [1] Hayes, Monson H. Statistical digital signal processing and modeling. 
    // John Wiley & Sons, 2009, pg. 220
    //
    // See also
    // aryule | levinson | prony | pyulear | stmcb
    //
    // Authors
    // Ayush Baid
    //

    // ** Check on number of arguments **
    [numOutArgs,numInArgs] = argn(0);
    
    if numInArgs<1 | numInArgs>2 then
        msg = "lpc: Wrong number of input argument; 1-2 expected";
        error(77,msg);
    end
    if numOutArgs~=2 then
        msg = "lpc: Wrong number of output argument; 2 expected";
        error(78,msg);
    end
    
    // ** Parsing input arguments **
    // 1) check on x
    
    // check on dimensions
    if size(x,1)==1 | size(x,2)==1 then
        // x is a single signal
        x = x(:); // converting to column vector
    end
    if ndims(x)>2 then
        msg = "lpc: Wrong size for argument #1 (x): a vector or 2D matrix expected"
        error(60,msg);
    end
    
    // check on data type
    if type(x)==8 then
        // convert int to double
        x = double(x);
    elseif type(x)~=1 then
        msg = "lpc: Wrong type for argument #1 (x): Real or complex matrix expected";
        error(53,msg);
    end
    
    if length(varargin)==0 then
        p = size(x,1)-1;
    else
        p = varargin(1);
        // 2) check on p
        if length(p)~=1 then
            msg = "lpc: Wrong size for argument #2 (p): Scalar expected";
            error(60,msg);
        end
        
        if type(p)~=1 & type(p)~=8 then
            msg = "lpc: Wrong type for argument #2 (p): Natural number expected";
            error(53,msg);
        end
        
        if p~=round(p) | p<=0 then
            msg = "lpc: Wrong type for argument #2 (p): Natural number expected";   
            error(53,msg);
        end
        
        if p>size(x,1) then
            msg = "lpc: Wrong value for argument #2 (p): Must be less than or equal to the length of the signal vector";   
            error(53,msg);
        end
        
        if ~isreal(p) then
            msg = "lpc: Wrong type for argument #2 (p): Real scalar expected";
            error(53,msg);
        end
    end
    
    num_signals = size(x,2);

    // ** Processing **
    N = size(x,1);
    
    // zero pad x
    x = [x; zeros(2^nextpow2(2*N-1)-N,size(x,2))];
    X = fft(x,-1,1);
    R = fft(abs(X).^2,1,1);
    R = R./N; // Biased autocorrelation estimate
    
    // change ieee mode to handle division by zero
    ieee_prev = ieee();
    ieee(2);
    [a,g] = ld_recursion(R,p);
    ieee(int(ieee_prev));
    
    
    // filter coeffs should be real if input is real
    for signal_idx=1:num_signals
        if isreal(x(:,signal_idx)) then
            a(signal_idx,:) = real(a(signal_idx,:)); 
        end
    end
    
endfunction

function [a,e] = ld_recursion(R,p)
    // Solve for LP coefficients using Levinson-Derbin recursion
    //
    // Paramaters
    // R: double
    //      Autocorrelation matrix where column corresponds to autocorrelation 
    //      to be treated independently
    // a: double
    //      Matrix where rows denote filter cofficients of the corresponding 
    //      autocorrelation values
    // e: double
    //      Column vector denoting error variance for each filter computation
    
    
    num_filters = size(R,2);
    
    
    // Initial filter (order 0)
    a = zeros(num_filters,p+1);
    a(:,1) = 1;
    e = R(1,:).';
    
    
    // Solving in a bottom-up fashion (low to high filter coeffs)
    for m=1:p
        k_m = -sum(a(:,m:-1:1).*R(2:m+1,:).',2)./e;
        a(:,2:m+1) = a(:,2:m+1) + k_m(:,ones(1,m)).*conj(a(:,m:-1:1));
        
        e = (1-abs(k_m).^2).*e;
    end
    
endfunction
