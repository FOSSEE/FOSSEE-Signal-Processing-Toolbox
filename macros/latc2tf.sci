function [num,den] = latc2tf(k,varargin)
    // Convert lattice filter parameters to transfer function coefficients
    //
    //
    // Calling sequence
    // [num,den] = latc2tf(k,v)
    // [num,den] = latc2tf(k,'iiroption')
    // num = latc2tf(k,'firoption')
    //
    //
    // Description
    // [num,den] = latc2tf(k,v)
    //      Finds the transfer function of the IIR filter from the lattice
    //      coefficients k and ladder coefficients v.
    // [num,den] = latc2tf(k,'iiroption')
    //      Finds the transfer function of the allpass or allpole (specified by 
    //      the iiroption flag) IIR filter.
    // num = latc2tf(k,'firoption')
    //      Finds the transfer function of the FIR filter from the lattice
    //      coefficients k. The firoption flag specifies the type of the FIR
    //      filter (can be 'min, 'max', or 'FIR')
    //
    // Parameters:
    // k - double - vector
    //      Lattice coefficients
    //      Lattice coefficients for FIR/IIR filter. Can be real or complex. 
    // v - double - vector
    //      Ladder coefficients
    //      Ladder coefficients for IIR filters. Can be real or complex.
    // iiroption - string flag - 'allpole', or 'allpass'
    //      Specification of the type if IIR filter
    // firoption - string flag - 'min', 'max', or 'FIR' (default)
    //      Speficication of the type of FIR filter
    // 
    // Examples
    // 1) FIR filter
    //      k1 = [1/2 1/2 1/4];
    //      [num1,den1] = latc2tf(k1);
    // 
    // See also
    // latcfilt | tf2latc
    //
    // References
    // [1] J.G. Proakis, D.G. Manolakis, Digital Signal Processing,
    //    3rd ed., Prentice Hall, N.J., 1996, Chapter 7.
    // [2] S. K. Mitra, Digital Signal Processing, A Computer
    //    Based Approach, McGraw-Hill, N.Y., 1998, Chapter 6.
    //
    // Authors
    // Ayush Baid
    
    
    [numOutArgs,numInArgs] = argn(0);
    
// ** Check on number of input arguments **
    if numOutArgs<1 | numOutArgs>2 then
        msg = "cummin: Wrong number of output argument; 1-2 expected";
        error(78,msg);
    end
    
    if numInArgs<1 | numInArgs>2 then
        msg = "cummin: Wrong number of input argument; 1-2 expected";
        error(77,msg);
    end
    
    
// ** Parsing the input arguments **

// 1) k:
//      must be a vector
//      can be real or complex valued, (negative values allowed)

    // checking data type
    if  ~(type(k)==1 | type(k)==8) then
        msg = "latc2tf: Wrong type for argument #1 (k); Real or complex vector expected";
        error(53,msg);
    end
    
    // checking the dimensions (must be a vector)
    if ~(size(k,1)==1 | size(k,2)==1) then
        msg = "latc2tf: Wrong type for argument #1 (k); Real or complex vector expected";
        error(53,msg);
    end
    // convert to column vector
    if size(k,1)==1 then
        k = k(:);
    end
    
    L = length(varargin);
// Parsing the 2nd argument
    if L>=1 then
        arg2 = varargin(1);
        // string check
        if type(arg2)==10 then
            if strcmpi(arg2,'FIR')==0 then
                [num,den] = latc2tf_fir(k,2);
            elseif strcmpi(arg2,'min')==0 then
                [num,den] = latc2tf_fir(k,0);
            elseif strcmpi(arg2,'max')==0 then
                [num,den] = latc2tf_fir(k,1);
            elseif strcmpi(arg2,'allpole')==0 then
                [num,den] = latc2tf_iir2(k,1);
            elseif strcmpi(arg2,'allpass')==0 then
                [num,den] = latc2tf_iir1(k);
            else
                msg = "latc2tf: Wrong value for argument #2 (string flag) ";
                error(53,msg);
            end
        elseif (type(arg2)==1 | type(arg2)==8) then
            // arg2 is ladder coefficients
            
            // check for vector input
            if ~(size(arg2,1)==1 | size(arg2,2)==1) then
                msg = "latc2tf: Wrong type for argument #2 (v); Real or complex vector expected";
                error(53,msg);
            end
            
            // convert to column vector
            if size(arg2,1)==1 then
                arg2 = arg2(:);
            end
            
            [num,den] = latc2tf_iir2(k,arg2);
            
        else
            msg = "latc2tf: Wrong type for argument #2; Real or complex vector" + ...
                "(ladder coeffs k) or string flag expected";
            error(53,msg);
        end
    else
        [num,den] = latc2tf_fir(k,2);
    end
    
    num = num';
    den = den';
    
endfunction

function [num,den] = latc2tf_fir(k,option)
    // latc2tf for FIR filters
    // Input Arguments
    // k:   lattice coefficients
    // option: 0 for min-phase (default), 1 for max-phase; 2 for fir
    
    if isempty(k) then
        num = 1;
        den = 1;
        return
    end

    den = 1;
    
    p = length(k);
    num = 1;

    for j=2:p+1
    	num = [num; 0] + k(j-1)*[0; conj(num($:-1:1,:))];
	end

	if option==1 then
		num = conj(num($:-1:1));
	end

    
endfunction

function [num,den] = latc2tf_iir1(k)
    // for all pass IIR filters
    
    if isempty(k) then
        num = 1;
        den = 1;
        return
    end

    p = length(k);
    den = 1;

    for j=2:p+1
    	den = [den; 0] + k(j-1)*[0; conj(den($:-1:1,:))];
	end

	num = conj(den($:-1:1));
    
   
endfunction 


function [num,den] = latc2tf_iir2(k,v)
    // for allpole and general IIR fitlers
    if isempty(k) & isempty(v) then
        num = [];
        den = [];
    elseif isempty(k) & length(v)==1 then
        num = v;
        den = 1;
    else
        // k is a column vector
        M = size(k,1)+1;
        
        // pad v with appropriate number of zeros
        l_v = size(v,1);
        diff = M - l_v;
        if diff>0 then
            v = [v; zeros(diff,1)];
        elseif diff<0 then
        	k = [k; zeros(-diff,1)];
    	end


        p = length(k);
    	den = 1;

    	for j=2:p+1
	    	den = [den; 0] + k(j-1)*[0; conj(den($:-1:1,:))];
		end
        
        exec('rlevinson.sci',-1);

        [r,temp] = rlevinson(den,1);

        num = (temp*v);
    end    

endfunction
