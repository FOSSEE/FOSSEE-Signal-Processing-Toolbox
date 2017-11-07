// Date of creation: 20 Jan, 2016
function [w,pow] = rootmusic(x,p,varargin)
    // Frequencies and power of sinusoids using the root MUSIC algorithm
    //
    // Calling Sequence
    // w = rootmusic(x,p)
    // [w,pow] = rootmusic(x,p)
    // [f,pow] = rootmusc(...,fs)
    // [w,pow] = rootmusic(...,'corr')
    //
    // Parameters
    // x - int|double - vector|matrix
    //      Input signal.
    //      If x is a vector, then it reprsenets one realization of the signal.
    //      If x is a matrix, then each row represents a separate observation of
    //      the signal. 
    // p - int|double - scalar|2 element vector
    //      p(1) is the signal subspace dimension and hence the number of 
    //      complex exponentials in x.
    //      p(2), if specified, represents a threshold that is multiplied by 
    //      the smallest estimated eigenvalue of the signal's correlation 
    //      matrix.
    // fs - int|double - scalar
    //      Sampling frequency (in Hz)
    //      If fs is specified by an empty vector or unspecified, it defaults
    //      to 1 Hz
    // 'corr' flag
    //      If specified, x is interpreted as a correlation matrix rather than
    //      a matrix of the signal data. For x to be a correlation matrix, 
    //      x must be a square matrix and all its eigenvalues must be 
    //      nonnegative
    //
    // Examples:
    //      1) 3 complex exponentials:
    //
    //          n=0:99;   
    //          s=exp(1i*pi/2*n)+2*exp(1i*pi/4*n)+exp(1i*pi/3*n)+randn(1,100);  
    //          [W,P] = rootmusic(s,3);
    //
    // Author
    // Ayush
    //
    // See also
    // corrmtx | peig | pmusic | rooteig
    //
    // References
    // 1) Monson H. Hayes, Statistical Digital Signal Processing And Modeling, 
    // Wiley & Sons, Inc, [Section 8.6.3]
    //
    //
    // Output arguments
    // w - double - vector
    //      Estimated frequencies of the complex sinusoids
    // pow - double - vector
    //      estimated absolute value squared amplitudes of the sinusoids at 
    //      the frequencies w 
    //
    
    funcprot(0);
    
    exec('musicBase.sci',-1);
    exec('nnls.sci',-1);  
    
    
    // **** checking the number of input and output arguments ****
    
    [numOutArgs, numInArgs] = argn(0);
    
    if numOutArgs~=1 & numOutArgs~=2 then
        error(78,"rootmusic");
    end
    
    if numInArgs<1 | numInArgs>4 then
        error(77,"rootmusic");
    end
    
    
    // **** parsing the input arguments ****
    isFsSpecified = %F;
    fs = [];
    
    varargLength = length(varargin);
    // searching for the 'corr' flag
    isCorrFlag = %F;
    
    if varargLength==0 then
        stringIndices = [];
    else
        stringIndices = find(type(varargin(1:varargLength))==10);
    end
    
    if ~isempty(stringIndices) then
        // ignoring all other strings except the corr flag
        isCorrFlag = or(strcmpi(varargin(stringIndices),"corr")==0);
        varargin(stringIndices) = [];
    end
    
    // varargin can have only an entry for fs
    if length(varargin)==1 then
        fs = varargin(1);
        if length(fs)==1 then
            if ~IsIntOrDouble(fs, %T) then
                msg = "rootmusic: Wrong type for argument #4 (fs); Positive scalar expected";
                error(msg,10084);
            end
            fs = double(fs);
            isFsSpecified = %T;
        elseif length(fs)>1 then
            msg = "rootmusic: Wrong type for argument #4 (fs); Positive scalar expected";
            error(msg,10084); 
        end
    elseif length(varargin)>1 then
        msg = "rootmusic: Wrong type for argument #4 (fs); Positive scalar expected";
        error(msg,10084);     
    end
    
    // extracting primary input x/R
    primaryInput = x;

    if ndims(primaryInput)<1 | ndims(primaryInput)>2 then
        msg = "rootmusic: Wrong dimension for argument #1; Vector or a matrix expected";
        error(msg,10053);
    end
    if ~IsIntOrDouble(primaryInput, %F) then
        msg = "rootmusic: Wrong type for argument #1; Numeric vector or a matrix expected";
        error(msg,10053);
    end
    // covert to a column vector
    if ndims(primaryInput)==1 then
        primaryInput = primaryInput(:);
    end
    // casting to double
    primaryInput = double(primaryInput);


    //****extracting p****
    // p must be either scalar or a 2-element vector
    if length(p)~=1 & length(p)~=2 then
        msg = "rootmusic: Wrong type for argument #2 (p); " + ...
            "A scalar or a 2-element vector expected";
        error(msg,10053);
    end
    // first argument of p must be an integer
    if ~IsIntOrDouble(p(1),%T) then
        msg = "rootmusic: Wrong input argument #2 p(1); " + ... 
            "positive integer expected";
        error(msg,10036);
        return
    end
    p(1) = int(p(1));
    // TODO: check if positive required
    // 2nd argument, if exists, must be a positive integer'
    if length(p)==2 then
        if ~IsIntOrDouble(p(2),%F) then
            msg = "rootmusic: Wrong type for argument #2 p(2); must be a scalar";
            error(msg,10053); 
        end
    end
    
    isXReal = isreal(x)
    if ~isCorrFlag then
        // check that p(1) should be even if x is real
        if isXReal & modulo(p(1),2)~=0 then
            msg = "rootmusic: Wrong input argument #2 p(1); " + ...
                " An even value expected for real input x";
            error(msg,10036);
        end
    end

    
    
    // **** calling pmusic ****
    data= struct();
    data.x = primaryInput;
    data.p = p;
    data.nfft = 256;
    data.w = [];
    data.fs = fs;
    data.isWindowSpecified = %F;
    data.windowLength = 2*p(1);
    data.windowVector = [];
    data.noverlap = [];
    data.isCorrFlag = isCorrFlag;
    data.isFsSpecified = isFsSpecified;
    data.freqrange = "twosided";

    

    [outData,msg] = musicBase(data);
    if length(msg)~=0 then
        // throw error
        msg = "rootmusic: "+msg
        error(msg);
    end
    
    pEffective = outData.pEffective;
    eigenvals = outData.eigenvals;
    
    w = computeFreqs(outData.noiseEigenvects,pEffective,%f,eigenvals);
    
    if isempty(w) then
        // assign all frequency and powers as -nan
        w = %nan*(1:pEffective)';
        pow = w;
        return;
    end
         
    
    // **** Estimating the variance of the noise ****
    // Estimate is the mean of the eigenvalues belonging to the noise subspace
    sigma_noise = mean(eigenvals(pEffective+1:$));
    
    pow = computePower(outData.signalEigenvects,eigenvals,w,pEffective,...
                sigma_noise,isXReal);
                
                
    // is fs is specified, convert normailized frequencies to actual frequencies
    if isFsSpecified then
        w = w*fs/(2*%pi);
    end
    
    
endfunction

function w = computeFreqs(noiseEigenvects,pEffective,EVFlag,eigenvals)
    // Computes the frequencies of the complex sinusoids using the roots of 
    // the polynomial formed with the noise eigenvectors
    //
    // Parameters
    // noiseEigenvects - 
    //      A matrix where noise eigenvectors are represented by each column
    // pEffective - 
    //      The effective dimension of the signal subspace
    // EVFlag - 
    //      Flag to indicate weighting to be used for rooteig
    // eigenvals - 
    //      Eigenvals of the correlation matrix
    //
    // Output arguments
    //  w - 
    //      A vector with frequencies of the complex sinusoids


    numOfNoiseEigenvects = size(noiseEigenvects,2);
    if EVFlag then
        // weights are the eigenvalues in the noise subspace
        weights = eigenvals($-numOfNoiseEigenvects+1:$);
    else
        weights = ones(numOfNoiseEigenvects,1);
    end
    
    // Form a polynomial consisting of a sum of polynomials given by the
    // product of the noise subspace eigenvectors and the reversed and 
    // conjugated version. (eq 8.163 from [1])
    D = 0;
    for i=1:numOfNoiseEigenvects
        eigenvect = noiseEigenvects(:,i);
        D = D + conv(eigenvect,conj(eigenvect($:-1:1)))./weights(i);
    end
    
    roots = roots(D);
    
    // selecting the roots inside the unit circle
    rootsSelected = roots(abs(roots)<1);
    
    // sort the roots in order of increasing distance from the unit circle
    [dist,indices] = gsort(abs(rootsSelected)-1);
    
    sortedRoots = rootsSelected(indices);
    
    if isempty(sortedRoots) then
        w = [];
    else
        w = atan(imag(sortedRoots(1:pEffective)),real(sortedRoots(1:pEffective)));
    end
    
    
endfunction


function power = computePower(signalEigenvects,eigenvals,w,pEffective,...
                    sigma_noise,isXReal)
                    
    if isXReal then
        // removing the negative frequencies as sinusoids will be present in 
        //  complex conjugate pairs
        w = w(w>=0);
        pEffective = length(w);
    end
    
    // Solving eq. 8.160 from [1] (Ap = b) where p is the power matrix
    
    A = zeros(length(w),pEffective);
    
    for i=1:pEffective
        A(:,i) = computeFreqResponseByPolyEval(signalEigenvects(:,i), ...
                        w,1,%F);
    end
    
    A = (abs(A).^2)';
    b = eigenvals(1:pEffective) - sigma_noise;
    
    // Solving Ap=b with the constraint that all elements of p >=0
    power = nnls(A,b+A*sqrt(%eps)*ones(pEffective,1));
    
    
endfunction

function h = computeFreqResponseByPolyEval(b,f,fs,isFsSpecified)
    // returns the frequency response (h) for a digital filter with numerator b.
    // The evaluation of the frequency response is done at frequency values f
    
    f = f(:);
    b = b(:);
    if isFsSpecified then
        // normalizing the f vector
        w = f*2*%pi/fs;
    else
        w = f;
    end
    
    n = length(b);
    powerMatrix = zeros(length(f),n);
    powerMatrix(:,1) = 1;
    for i=2:n
        powerMatrix(:,i) = exp(w*(-i+1)*%i);
    end
    
    h = powerMatrix*b;
     
endfunction    
    

function result = IsIntOrDouble(inputNum, isPositiveCheck)
    // Checks if The Input Is Integer Or Double
    // Also Checks if It Is Greater Than 0 For IsPositiveCheck = True

    if ~(type(inputNum)==1 | type(inputNum)==8) then
        result = %F;
        return
    end
    if isPositiveCheck & or(inputNum<=0) then
        result = %F;
        return
    end

    result = %T;
    return
endfunction
