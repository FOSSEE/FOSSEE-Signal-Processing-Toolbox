function filter_coeffs = gaussdesign(BwSt_prod, num_of_symb, samp_per_symb)
// Design a Gaussian pulse-shaping filter.
//
// Syntax
//   filter_coeffs = gaussdesign(BwSt_prod, num_of_symb, samp_per_symb)
//
// Parameters
// BwSt_prod: Scalar. The 3 dB bandwidth-symbol time product. Bandwidth is one-sided and in hertz, and symbol time is in seconds.
// num_of_symb: Positive integer. The number of symbols to which the filter is truncated. Default is 3.
// samp_per_symb: Positive integer. The number of samples representing each symbol. Default is 2.
// filter_coeffs: Vector. The coefficients of the designed Gaussian filter.
//
// Description
// This function designs a Gaussian pulse-shaping filter, which is a low-pass FIR filter. The filter is defined by the 3 dB bandwidth-symbol time product (`BwSt_prod`), the number of symbols (`num_of_symb`), and the number of samples per symbol (`samp_per_symb`). The filter coefficients are normalized such that their sum equals 1.
//

    // Check validity of number of inout arguments
    checkNArgin(1, 3, argn(2));
    
    // Check validity of number of output arguments
    checkNArgout(0, 1, argn(1));
    
    // Check validity of input arguments
    valid_class_BwSt = ['single', 'double'];
    properties_BwSt = ['scalar', 'nonempty', 'nonNan', 'real', 'positive'];
    checkIpValidity(BwSt_prod, valid_class_BwSt, properties_BwSt);
    
    if (argn(2) >= 2) then
        valid_class_nos = ['single', 'double'];
        properties_nos = ['scalar', 'nonempty', 'nonNan', 'real', 'positive', 'integer'];
        checkIpValidity(num_of_symb, valid_class_nos, properties_nos);
    else
        num_of_symb = 3;
    end
    
    if argn(2) == 3 then
        valid_class_sps = ['single', 'double'];
        properties_sps = ['scalar', 'nonempty', 'nonNan', 'real', 'positive', 'integer'];
        checkIpValidity(samp_per_symb, valid_class_sps, properties_sps);
    else
        samp_per_symb = 2;
    end
    
    // check if inputs fit the symmetry condition
    if pmodulo(num_of_symb*samp_per_symb, 2) ~= 0  then
        error('product of number_of_symbols and samples_per_symbol should be even');
    end
    
    // Finding the filter coefficients
    length_of_filt = (num_of_symb*samp_per_symb) + 1;
    ax = linspace((-num_of_symb/2), (num_of_symb/2), length_of_filt);
    den = sqrt(log(2)/2)/(BwSt_prod);
    filter_coeffs_tmp = (sqrt(%pi)/den)*exp(-(ax*%pi/den).^2);
    
    // Normalizing
    filter_coeffs = filter_coeffs_tmp./sum(filter_coeffs_tmp);    
    
endfunction

function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
    end
endfunction


function checkNArgout(min_argout, max_argout, num_of_argout)
    if num_of_argout < min_argout then
        error('Not enough output arguments')
    end
    
    if num_of_argout > max_argout then
        error('Too many output arguments')
    end
endfunction

function checkIpValidity(variable, valid_class, properties)
// Function to check the validity of the input variable
// Inputs: 
//      valid_class: vector of valid classes for the input variable
//      properties: vector of necessary properties of the input variable

    for idx = 1:length(length(valid_class))
        if ~strcmpi(valid_class(idx), 'double') | ~strcmpi(valid_class(idx), 'single')  then
            if type(variable) ~= 1 then
                error('input variable should be of type double ');
            end
        end
    
    end
    
    for jdx = 1:length(length(properties))
        if ~strcmpi(properties(jdx), 'scalar') then
            if length(variable) > 1 then
                error('Input variable should be of type scalar');
            end
        end

        if ~strcmpi(properties(jdx), 'nonempty') then
            if isempty(variable) then
                error('Input variable is empty. It is invalid');
            end
        end
        
        if ~strcmpi(properties(jdx), 'nonNan') then
            if isnan(variable) then
                error('Input variable is not a number (Nan). It is invalid');
            end
        end
        
        if ~strcmpi(properties(jdx), 'real') then
            if ~isreal(variable) then
                error('Input should be real');
            end
        end
        
        if ~strcmpi(properties(jdx), 'positive') then
            if variable <= 0 then
                error('Input should be positive');
            end
        end
        
        if ~strcmpi(properties(jdx), 'integer') then
            if (int(variable)-variable) ~= 0 then
                error('Input should be an integer');
            end
        end
    end

endfunction
