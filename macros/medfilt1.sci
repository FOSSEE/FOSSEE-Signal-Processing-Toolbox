function y = medfilt1(x, varargin)
    // 1D median filtering
    //
    // Calling sequence
    // y = medfilt1(x)
    // y = medfilt1(x, n)
    // y = medfilt1(x, n, dim)
    // y = medfitl1(__, nanflag, padding)
    // 
    // Description
    // y = medfilt1(x)
    //      Applies a 3rd order 1-dimensional median filter to input x along the
    //      first non-zero dimension. The function appropriately pads the signal
    //      with zeros at the endings. For a segment, a median is calculated as
    //      the middle value (average of two middle values) for odd number
    //      number (even number) of data points.
    // y = medfilt1(x,n)
    //      Applies a nth order 1-dimensional median filter.
    // y = medfilt1(x,n,dim)
    //      Applies the median filter along the n-th dimension
    // y = medfilt1(__, nanflag, padding)
    //      nanflag specifies how NaN values are treated. padding specifies the 
    //      type of filtering to be performed at the signal edges.
    //
    // Parameters
    // x: int | double
    //      Input signal.
    // n: positive integer scalar
    //      Filter order. 
    //      Defaults to 3.The order of the median filter. Must be less than 
    //      (length of the signal) where signals are 1D vectors along the 
    //      dimension of x to be filtered
    // dim: positive integer scalar
    //      Dimension to filter along. 
    //      Defaults to first non-singleton dimension of x
    // nanflag: 'includenan' (default) | 'omitnan'
    //      NaN condition.
    //      * includenan: Filtering such that the median of any segment
    //          containing a NaN is also a NaN.
    //      * omitnan: Filtering with NaNs omitted in each segment. If a segment
    //          contains all NaNs, the result is NaN
    // y: int | double
    //      The filtered signal.
    //      y has the same size as x
    //
    // Examples
    // 1) Noise supression using median filtering
    //      fs = 1e3;
    //      t =  1:1/fs:1;
    //      s = sin(2*%pi*2*t)+ cos(2*%pi*5*t);
    //      // Adding noise
    //      x = s + 0.1*randn(size(s));
    //      y = medfilt1(x);
    //
    // See also
    // filter | hampel | median | sgolayfilt
    //
    // Authors
    // Ayush Baid
    
    
    
    // ************************************************************************* 
    // Checking number of arguments 
    // *************************************************************************
    [numOutArgs, numInArgs] = argn(0);
    
    if numInArgs<1 | numInArgs>5 then
        msg = "medfilt1: Wrong number of input argument; 1-5 expected";
        error(77, msg);
    end
    if numOutArgs~=1 then
        msg = "medfilt1: Wrong number of output argument; 1 expected";
        error(78, msg);
    end
    
    
    
    // *************************************************************************
    // Parsing input arguments
    // *************************************************************************
    
    // * Parsing x *
    temp = x(:);
    if type(temp)~=1 & type(temp)~=8 then
        msg = "medfilt1: Wrong type for argument #1 (x): Int/double expected"
        error(53, msg);
    end
    
    
    // * Parsing nanflag and padding *
    // Getting all the string arguments
    stringIndices = list();  
    for i=1:length(varargin);
        e = varargin(i);
        if type(e)==10 then
            stringIndices($+1)=i;
        end
    end
    
    nanflag = %f; // 0->includenan (default); 1->omitnan
    padflag = %t; // 1->zeropad (default); 0->truncate
    if ~isempty(stringIndices) then
        // checking for 'omitnan'
        if or(strcmpi(varargin(stringIndices), 'omitnan')) then
            nanflag = %t;
        end
        
        // checking for 'truncate'
        if or(strcmpi(varargin(stringIndices), 'truncate')) then
            padflag = %f;
        end
        varargin(stringIndices) = [];
    end
    
    
    // setting default value for n and dim
    n = 3;
    dim = 1;
    L = length(size(x));
    for i=1:L
        if size(x, i)>1 then
            dim = i;
        end
    end
    
    // * Parsing n and dim *
    if length(varargin)==1 then
        if ~isempty(varargin(1)) then
            n = varargin(1);
        end
    elseif length(varargin)==2 then
        if ~isempty(varargin(1)) then
            n = varargin(1);
        end
        if ~isempty(varargin(2)) then
            dim = varargin(2);
        end
    else
        msg = "medfilt1: Wrong type of input arguments; Atmost 3 numerical input expected";
        error(53, msg);
    end
    
    // check on n
    if length(n)~=1 then
        msg = "medfilt1: Wrong size for argument #2 (n): Scalar expected";
        error(60,msg);
    end
    
    if type(n)~=1 & type(n)~=8 then
        msg = "medfilt1: Wrong type for argument #2 (n): Natural number expected";
        error(53,msg);
    end
    
    if n~=round(n) | n<=0 then
        msg = "medfilt1: Wrong type for argument #2 (n): Natural number expected";   
        error(53,msg);
    end

    if ~isreal(n) then
        msg = "medfilt1: Wrong type for argument #2 (n): Real scalar expected";
        error(53,msg);
    end
    
    // check on dim
    if length(dim)~=1 then
        msg = "medfilt1: Wrong size for argument #3 (dim): Scalar expected";
        error(60,msg);
    end
    
    if type(dim)~=1 & type(dim)~=8 then
        msg = "medfilt1: Wrong type for argument #3 (dim): Natural number expected";
        error(53,msg);
    end
    
    if dim~=round(dim) | dim<=0 then
        msg = "medfilt1: Wrong type for argument #3 (dim): Natural number expected";   
        error(53,msg);
    end

    if ~isreal(dim) then
        msg = "medfilt1: Wrong type for argument #3 (dim): Real scalar expected";
        error(53,msg);
    end

    
    // *************************************************************************
    // Processing for median filtering column by column
    // *************************************************************************

    inp_size = size(x);

    
    // Permuting x to bring the dimension to be acted upon as the first dimesnion
    perm_vec = [2:dim, 1, dim+1:length(inp_size)];
    reverse_perm_vec = [dim, 1:dim-1, dim+1:length(inp_size)];
    x = permute(x, perm_vec);

    size_vec = size(x);
    
    y = x;  // just initialization

    for i=1:prod(size_vec(2:$))
        temp = medfilt_colvector(x(:,i), n, padflag, nanflag);
        y(:,i) = temp;
    end
    
    
    
    y = permute(y, reverse_perm_vec);
    
    
endfunction

function med = medfilt_colvector(x, n, zeropadflag, nanflag)
    // Performs median filtering (of order n) on a column vector (x)
    // zeropadflag -> zero pad instead of truncation
    // nanflag -> discard all blocks containing nan, else do not consider nan values
    
    med = zeros(size(x,1),1);
    disp('here1');
    
    
    // ** zero pad the signal **
    pad_length = floor(n/2);  // padding on a size
    x = [zeros(pad_length,1); x; zeros(pad_length,1)];
    
    nx = length(x);

    // Arrange data in blocks
    top_row = 1:(nx-n);
    
    idx = zeros(n,length(top_row));
    
    for i=1:n
        idx(i,:) = top_row + (i-1);
    end
    
    blocks = matrix(x(idx), size(idx));
    
    
    if nanflag then
        disp('here2');
        med = median(blocks, 1)';
   
        // set result of all the blocks containing nan to nan
        nanpresent = or(isnan(blocks), 1);
        med(nanpresent) = %nan;
    else
        disp('here3');
        // we have to neglect nans
        sorted_blocks = gsort(blocks, 'r', 'i');
        
        // get the count of non-nan elements
        num_elems = n - sum(isnan(sorted_blocks), 1);
        
        // find the median
        offset = (0:size(blocks,2)-1)*size(blocks,1);
        idx1 = offset+ceil(num_elems/2);
        idx2 = offset+ceil((num_elems/2)+0.25);

        
        // temporarily setting idx1 to 1 so as to not give errors in median calc.
        // Will later replace values at such indices with Nan
        idx1(idx1==0)=1;
        med = (sorted_blocks(idx1) + sorted_blocks(idx2))./2;
        
        med(idx1==0) = %nan;
    end

    if ~zeropadflag then
        // ** recalculate boundary blocks with truncation truncate at the boundaries **
        
        // divide the input signal into 3 parts; 1st and last part have truncation
        for i=ceil(n/2):n
            // ** first part **
            block = x(1:i);
            
            // * median calc for a block *
            if nanflag then
                med(i-ceil(n/2)+1) = median(block, 1);
   
                // set result of all the blocks containing nan to nan
                nanpresent = or(isnan(block), 1);
                if nanpresent then
                     med(i-ceil(n/2)+1) = %nan;
                end
            else
                // we have to neglect nans
                sorted_block = gsort(block, 'r', 'i');
        
                // get the count of non-nan elements
                num_elems = length(block) - sum(isnan(sorted_block), 1);
        
                // find the median
                idx1 = ceil(num_elems/2);
                idx2 = ceil(num_elems/2+0.25);
                
            
                // temporarily setting idx1 to 1 so as to not give errors in median calc.
                // Will later replace values at such indices with Nan
                if idx1==0 then
                    med(i-ceil(n/2)+1) = %nan;
                else
                    med(i-ceil(n/2)+1) = (sorted_block(idx1, :)+sorted_block(idx2, :))./2;
                end
            end 
            
            
            // ** last part **
            block = x($:-1:$-i);
            
            // * median calc for a block *
            if nanflag then
                med($+ceil(n/2)-i) = median(block, 1);
   
                // set result of all the blocks containing nan to nan
                nanpresent = or(isnan(block), 1);
                if nanpresent then
                     med($-ceil(n/2)+i) = %nan;
                end
                     med($+ceil(n/2)-i) = %nan;             
            else
                // we have to neglect nans
                sorted_block = gsort(block, 'r', 'i');
        
                // get the count of non-nan elements
                num_elems = length(block) - sum(isnan(sorted_block), 1);
        
                // find the median
                idx1 = ceil(num_elems/2);
                idx2 = ceil(num_elems/2+0.25);
            
                // temporarily setting idx1 to 1 so as to not give errors in median calc.
                // Will later replace values at such indices with Nan
                if idx1==0 then
                    med($+ceil(n/2)-i) = %nan;
                else
                    med($+ceil(n/2)-i) = (sorted_block(idx1) + sorted_block(idx2))./2;
                end
            end
        end
    end

endfunction
