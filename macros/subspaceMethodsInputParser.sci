// Date of creation: 17 Dec, 2015
function [data, msg, err_num] = subspaceMethodsInputParser(inputArgsList)
    // Input parser to be used by pmusic and peig

    // primaryInput, p, w, nfft, fs, nwin, noverlap, freqrange, isCorrFlag

    // NOTE: not accepting <x,p,w,nfft> as it is indistinguishable from <x,p,f,fs>

    // Input combinations
    // x, p
    // x, p, w
    // x, p, nfft
    // x, p, nfft, fs
    // x, p, f, fs
    // x, p, nfft, fs, nwin, noverlap

    // 'corr' flag with everyone
    // freqrange string



    // Output arguments description:
    // data - struct with the following arguments
    //      x - input signal or correlation matrix
    //      p - scalar|2-element vector - signal subspace parameters
    //      w/f - vector
    //      nfft - positive scalar
    //      fs - positive scalar
    //      isWindowSpecified - boolean indicating if window specified in the 
    //                          input params
    //      windowLength - positive scalar
    //      windowVector - vector
    //      noverlap - scalar
    //      freqrange - string
    //      isCorrFlag - boolean
    //      isFsSpecified - boolean indicating if fs argument is present
    //                      (fs can be empty)
    // 
    // msg - error message (if any)
    // err_num - error number (if any; otherwise -1)


    msg = "";
    err_num = -1;
    data = struct();
    
    numOfInputArgs = length(inputArgsList);

    // ****getting indices of all string input arguments****
    stringIndices = list();  
    for i=1:numOfInputArgs
        e = inputArgsList(i);
        if type(e)==10 then
            stringIndices($+1)=i;
        end
    end


    isCorrFlag = %F;
    isOneSided = %F;
    isTwoSided = %F;
    isCentered = %F;
    
    if ~isempty(stringIndices) then
        // ****checking for corr flag****
        isCorrFlag = or(strcmpi(inputArgsList(stringIndices),"corr")==0);

        // ****checking for freqrange****
        isOneSided = or(strcmpi(inputArgsList(stringIndices),"onesided")==0);
        isTwoSided = or(strcmpi(inputArgsList(stringIndices),"twosided")==0 ...
                    | strcmpi(inputArgsList(stringIndices),"whole")==0);
        isCentered = or(strcmpi(inputArgsList(stringIndices),"centered")==0);
    end
    
    freqrange = "";
    if isTwoSided then
        freqrange = "twosided";
    elseif isCentered then
        freqrange = "centered";
    else
        freqrange = "onesided";
    end

    // deleting the string arguments from inputArgsList
    for index=stringIndices
        inputArgsList(index) = null();
    end


    L = length(inputArgsList);
    if L<2 then
        msg = "Input arguments must have x (signal) or R (corr. matrix)" + ...
        "as 1st argument and p as 2nd argument";
        err_num = 72;
        return
    elseif L>6 then
        msg = "Atmost 6 numeric arguments expected";
        err_num = 72;
        return
    end


    // **** extracting x/R (signal/corr. matrix)
    primaryInput = inputArgsList(1);

    if ndims(primaryInput)<1 | ndims(primaryInput)>2 then
        msg = "Wrong dimensions for argument #1; must be a vector or a matrix";
        err_num = 60;
        return
    end
    if ~IsIntOrDouble(primaryInput, %F) then
        msg = "Wrong type for argument #1; int or double expected";
        err_num = 84;
        return
    end
    // covert to a column vector
    if ndims(primaryInput)==1 then
        primaryInput = primaryInput(:);
    end
    // casting to double
    primaryInput = double(primaryInput);


    //****extracting p****
    p = inputArgsList(2);

    // p must be either scalar or a 2-element vector
    if length(p)~=1 & length(p)~=2 then
        msg = "Wrong size of argument #2 (p); " + ...
        "must be a scalar or a 2-element vector";
        err_num = 60;
        return
    end
    // first argument of p must be an integer
    if ~IsIntOrDouble(p(1),%T) then
        msg = "Wrong type for p(1); must be a positive integer";
        err_num = 84;
        return
    end
    p(1) = int(p(1));
    // TODO: check if positive required
    // 2nd argument, if exists, must be a positive integer'
    if length(p)==2 then
        if ~IsIntOrDouble(p(2),%F) then
            msg = "Wrong type for p(2); must be a scalar";
            err_num = 84;
            return 
        end
    end

    // ****extracting the remaining arguments****

    // assigning default values
    w = [];
    fs = 1;
    isFsSpecified = %F;
    nfft = 256;
    windowLength = 2*p(1);
    isWindowSpecified = %F;
    windowVector = [];
    if windowLength==%inf then
        windowLength=[];
    end

    noverlap = [];


    if L==3 then
        // (x,p,w), and (x,p,nfft) are candidates
        temp3 = inputArgsList(3);
        

        // should be a vector or a scalar
        if size(temp3, 1)~=1 & size(temp3, 2)~=1 then
            msg = "Wrong dimension for argument #3; must be a scalar|vector";
            err_num = 60;
            return
        end

        if isempty(temp3) then
            nfft = 256;
        elseif length(temp3)==1 then
            // must be nfft

            // positive integer check
            if ~type(temp3)==8 | temp3<=0 then
                msg = "Wrong type for argument #3 (nfft); must be a positive integer";
                err_num = 84;
                return
            end

            nfft = temp3;
        else
            // must be w

            // numeric type check
            if ~IsIntOrDouble(temp3, %F) & or(temp3<0) then
                msg = "Wrong type for argument #3 (w); must be int or double";
                err_num = 82;
                return
            end
            w = double(temp3(:)); // converting to column vector
        end

    elseif L==4 then
        // (x, p, nfft, fs), and (x, p, f, fs) are candidates
        temp3 = inputArgsList(3);
        temp4 = inputArgsList(4);

        // should be a vector
        if size(temp3, 1)~=1 & size(temp3, 2)~=1 then
            msg = "Wrong dimension for argument #3; must be a scalar/vector";
            err_num = 60;
            return
        end


        if isempty(temp3) then
            // nfft and fs
            nfft = 256;

            if length(temp4)==1 then
                if ~IsIntOrDouble(temp4, %T) then
                    msg = "Wrong type for argument #4 (fs); must be a positive scalar";
                    err_num = 84;
                    return
                end
                fs = double(temp4);
                isFsSpecified = %T;
            end
        elseif length(temp3)==1 then
            // nfft, fs

            // positive integer check
            if ~(type(temp3)==1 | type(temp3)==8) | temp3<=0 then
                msg = "Wrong type for argument #3 (nfft); must be a positive integer";
                err_num = 84;
                return
            end
            nfft = temp3;

            if length(temp4)==1 then
                if ~IsIntOrDouble(temp4, %T) then
                    msg = "Wrong type for argument #4 (fs); must be a positive scalar";
                    err_num = 84;
                    return
                end
                fs = double(temp4);
                isFsSpecified = %T;
            end
        else
            // (f,fs)

            // numeric type check
            if ~IsIntOrDouble(temp3, %F) & or(temp3<0) then
                msg = "Wrong type for argument #3 (f); must be int or double";
                err_num = 82;
                return
            end
            w = double(temp3(:));

            if length(temp4)~=1 then
                msg = "Wrong dimension for argument #4 (fs); must be a positive scalar";
                err_num = 84;
                return
            else
                if ~IsIntOrDouble(temp4, %F) then
                    msg = "Wrong type for argument #4 (fs); must be a positive scalar";
                    err_num = 84;
                    return
                end
                fs = double(temp4);
                isFsSpecified = %T;
            end 
        end
        
    elseif L>=5 then
        // nfft, fs, nwin, noverlap
        nfft = inputArgsList(3);
        fs = inputArgsList(4);
        temp5 = inputArgsList(5);
        if L==6 then
            noverlap = inputArgsList(6);
        end

        if isempty(nfft) then
            nfft = 256;
        elseif ~length(nfft)==1 | ~IsIntOrDouble(nfft,%T) then
            msg = "Wrong type for argument #3 (nfft); must be a positive integer";
            err_num = 84;
            return 
        end

        if isempty(fs) then
            fs = 1;
        elseif ~length(fs)==1 | ~IsIntOrDouble(fs, %T) then
            msg = "Wrong type for argument #4 (fs); must be a positive scalar";
            err_num = 84;
            return
        else
            isFsSpecified = %T;
        end

        // parsing window paramater
        if length(temp5)==1 then
            // window length is specified
            if ~IsIntOrDouble(temp5,%T) then
                msg = "Wrong type for argument #5 (nwin); must be a positive integer or a numeric vector";
                err_num = 40;
                return
            end
            windowLength = int(temp5);
            isWindowSpecified = %T;
            // windowVector = window('re',windowLength);
        elseif ndims(temp5)==1 then
            // window is specified
            if ~IsIntOrDouble(temp5, %F) then
                msg = "Wrong type for argument #5 (nwin); must be a positive integer or a numeric vector";
                err_num = 40;
                return
            end
            windowVector = double(temp5(:));
            windowLength = length(windowVector);
            isWindowSpecified = %T;
        elseif ~isempty(temp5) then
            msg = "Wrong type for argument #5 (nwin); must be a positive integer or a numeric vector";
            err_num = 40;
            return
        end


        // noverlap
        if isempty(noverlap) then
            noverlap = windowLength-1;  
        elseif length(noverlap)==1 then
            if ~(type(noverlap)==8 | type(noverlap)==1)| noverlap<0 then
                msg = "Wrong type for argument #6 (noverlap); must be a non-negative integer";
                err_num = 84;
                return;
            end
            noverlap = int(noverlap);         
        else
            msg = "Wrong type for argument #6 (noverlap); must be a non-negative integer";
            err_num = 84;
            return;
        end
    end
    
    // assigning default value for freqrange if not already specified
    if length(freqrange)==0 then
        if isreal(x) then
            freqrange = "onesided";
        else
            freqrange = "twosided";
        end
    end
    
    
    // normalizing w if it exists
    if ~isempty(w) & isFsSpecified then
        w = w*2*%pi/fs;
    end
    
    
    data.x = primaryInput;
    data.p = p;
    data.w = w;
    data.nfft = nfft;
    data.fs = fs;
    data.isWindowSpecified = isWindowSpecified;
    data.windowLength = windowLength;
    data.windowVector = windowVector;
    data.noverlap = noverlap;
    data.freqrange = freqrange;
    data.isCorrFlag = isCorrFlag;
    data.isFsSpecified = isFsSpecified;


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
