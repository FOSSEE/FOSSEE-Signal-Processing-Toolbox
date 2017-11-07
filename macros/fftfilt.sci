function y = fftfilt(b, x, varargin)
    // Performs FFT-based FIR filtering using overlap-add method
    // 
    // Calling sequence
    // y = fftfilt(b,x)
    // y = fftfilt(b,x,n)   
    // 
    // Parameters
    // x: real|complex numbers -  vector|matrix
    //      Input data to be filtered
    //      If x is a matrix, each column is treated as an independent observation.
    // b: real|complex numbers - vector|matrix
    //      Filter coefficients
    //      If b is a matrix and x is a vector, each column is treated as an 
    //      independent filter. If both x and b are matrices, each column of x
    //      if filtered using corresponding column of b.
    // n: positive integer
    //      Parameter used to determine the length of the fft
    //
    // Description
    // y = fftfilt(b,x) filters the data in vector x with the filter described 
    //                  by coefficient vector b.
    // y = fftfilt(b,x,n) uses n to determine the length of the FFT.
    //
    // Examples
    // 1) Filtering a sine wave
    //      x = sin(1:2000);
    //      b = [1 1/2];
    //      y = fftfilt(b,x);
    // 2) Multiple filters (1,1/3) and (1/4,1/5);
    //      x = sin(1:2000);
    //      b = [1 1/4;1/3 1/5];
    //      y = fftfilt(b,x);
    //
    // Authors
    // Ayush Baid




    [numOutArgs,numInArgs] = argn(0);
    
// ** Checking number of arguments
    
    if numInArgs<1 | numInArgs>3 then
        msg = "fftfilt: Wrong number of input argument; 1-3 expected";
        error(77,msg);
    end
    
    if numOutArgs~=1 then
        msg = "fftfilt: Wrong number of output argument; 1 expected";
        error(78,msg);
    end
    
    // variables to keep track if the input vectors are column vectors
    transform_x = %f;
    
// ** checking the type of input arguments **
    if isempty(b) then
        y = zeros(size(x,1),size(x,2));
        return;
    end
    
    // b should contain numeric entries
    if ~(type(b)==1 | type(b)==8 | type(b)==17) then
        msg = "fftfilt: Wrong type for argument #1 (b); Real or complex entries expected ";
        error(53,msg);
    end
    
    // x should contain numeric entries
    if ~(type(x)==1 | type(x)==8 | type(x)==17) then
        msg = "fftfilt: Wrong type for argument #2 (x); Real or complex entries expected ";
        error(53,msg);
    end
    temp = size(x,1);
    
    // b and x must have compatible dimensions
    inpType = 0; 
    if size(b,1)==1 | size(b,2)==1 then
        // b is a vector; hence x can be a matrix
        inpType = 1;
        // if x is a vector; it should be a column vector
        if size(x,1)==1 then
            x = x(:);
            transform_x = %t;
        end
        
        // covert b to column vector
        b = b(:);
    else
        // b is a matrix, hence x should either be a vector or a matrix with 
        // same number of columns
        
        if size(x,1)==1 | size(x,2)==1 then
            inpType = 2;
            if size(x,1)==1 then
                x = x(:);
                transform_x = %t;
            end
        else 
            // check compatibility
            if size(b,2)~=size(x,2) then
                msg = "fftfilt: Wrong size for arguments #1 (b) and #2 (x); Must have same number of columns";
                error(60,msg);
            end
            inpType = 3;
        end        
    end


    // getting the length of data vector x
    nx = size(x,1);
    nb = size(b,1);

    if numInArgs==2 then // the param n was not passed
        // figure out the nfft (length of the fft) and L (length of fft inp block)to be used
        if (nb>=nx | nb>2^20) then 
            // take a single fft
            nfft = 2^nextpow2(nb+nx-1);
            L = nx;
        else
            // estimated flops for the fft operation (2.5nlog n for n in powers of 2 till 20)
            fftflops = [5, 20, 60, 160, 400, 960, 2240, 5120, 11520, 25600, 56320, 122880, 266240, 573440, 1228800, 2621440, 5570560, 11796480, 24903680, 52428800];
            n = 2.^(1:20); 
            candidateSet = find(n>(nb-1));    // all candidates for nfft must be > (nb-1)
            n  = n(candidateSet);
            fftflops = fftflops(candidateSet);

            // minimize (number of blocks)*(number of flops per fft)
            L = n - (nb - 1);
            numOfBlocks = ceil(nx./L);
            [dum,ind] = min( numOfBlocks .* fftflops ); // 
            nfft = n(ind);
            L = L(ind);

        end
    else  // nfft is given
        if nfft < nb then
            nfft = nb;
        end
        nfft = 2.^(ceil(log(nfft)/log(2))); // forcing nfft to a power of 2 for speed
        L = nfft - nb + 1;
    end

    // performing fft on b

    if nb<nfft then
        // perform padding
        temp = zeros(nfft-nb,size(b,2));
        b = [b; temp];
    end
    B = fft(b,-1,1);
    
    // replication x or b to match the number of columns
    if inpType==1 & size(x,2)~=1 then
        B = B(:,ones(1,size(x,2)));
    elseif inpType==2 then
        x = x(:,ones(1,size(b,2)));
    end
    

    
    y=zeros(size(x,1),size(x,2));
    
    blockStartIndex = 1;
    while blockStartIndex <= nx,
        blockEndIndex = min(blockStartIndex+L-1, nx);

        if blockEndIndex==blockStartIndex then
            // just a scalar in the block
            X = x(blockStartIndex(ones(nfft,1)),:);
        else
            block = x(blockStartIndex:blockEndIndex,:);
            // performing padding
            temp = nfft-(blockEndIndex-blockStartIndex)-1;
            if temp>0 then
                pad = zeros(temp,size(block,2));
                block = [block; pad];   
            end

            X = fft(block,-1,1);
        end
        Y = fft(X.*B,1,1);

        yEndIndex = min(nx, blockStartIndex+nfft-1);

        y(blockStartIndex:yEndIndex,:) = y(blockStartIndex:yEndIndex,:) + Y(1:(yEndIndex-blockStartIndex+1),:);

        blockStartIndex = blockStartIndex+L;
    end
    
    
    // if both data and filter coeffs were real, the output should be real
    if ~(or(imag(b(:))) | or(imag(x(:)))) then
        y = real(y);
    end


    if inpType==1 & transform_x then
        y = y';
    end
    

endfunction



