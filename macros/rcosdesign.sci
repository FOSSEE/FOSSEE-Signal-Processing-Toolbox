function h = rcosdesign(rollof_factor, num_of_symb, samp_per_symb, varargin)
// RCOSDESIGN computes the raised cosine FIR filter
// Inputs: 
//      rollof_fact: roll-off factor of the designed filter
//      num_of_symb: filter truncated to these many number of symbols
//      samp_per_symb: each symbol represented by these many samples
//      shape: returns a normal raised-cosine FIR filter when set to 'normal'.
//             returns a square-root raised cosing filter when set to 'sqrt'.
// Output: 
//      h: returned filter coefficients
//The output result for the input parameter of shape 'normal' is not equivalent to the matlab output because of the use of sinc function in the computation. Matlab and scilab sinc functions seem to not be equivalent.


    // Check validity of number of inout arguments
    checkNArgin(3, 4, argn(2));
    
    // Check validity of input arguments
    valid_class_ROF = ['single', 'double'];
    properties_ROF = ['scalar', 'real', 'nonNegative'];
    checkIpValidity(rollof_factor, valid_class_ROF, properties_ROF);
    if rollof_factor > 1 then
        error('roll-off factor should be <= 1');
    end
    
    if rollof_factor == 0 then
        rollof_factor = number_peroperties("tiny");
    end

    valid_class_NOS = ['single', 'double'];
    properties_NOS = ['scalar', 'real', 'positive', 'finite'];
    checkIpValidity(num_of_symb, valid_class_NOS, properties_NOS);
    
    valid_class_SPS = ['single', 'double'];
    properties_SPS = ['scalar', 'real', 'positive', 'finite', 'integer'];
    checkIpValidity(samp_per_symb, valid_class_SPS, properties_SPS);
    
    if pmodulo((num_of_symb*samp_per_symb), 2) ~= 0 then
        error('product of number_of_symbols and samples_per_symbol should be even');
    end
    
    
    if argn(2) > 3 then
        shape = varargin(1);
    else
        shape = 'sqrt';
    end
    
    valid_string_shape = ['sqrt', 'normal'];
    checkStringValidity(shape, valid_string_shape);
    
    // Designing the raised cosine filter
    
    pr = (samp_per_symb*num_of_symb)/2;
    ax = (-pr:pr)/samp_per_symb;
    
    if ~strcmpi(shape, 'normal') then
        den = (1-(2*rollof_factor*ax).^2);
        id1 = find(abs(den) > sqrt(%eps));
        for idx = 1:length(id1)
            filt_resp(id1(idx)) = sinc(ax(id1(idx))).*(cos(%pi*rollof_factor*ax(id1(idx)))./den(id1(idx)))/samp_per_symb;
        end
        
        id2 = 1:length(ax);
        id2(id1) = [];
        for idx = 1:length(id2)
            filt_resp(id2(idx)) = rollof_factor*sin(%pi/(2*rollof_factor))/(samp_per_symb);
        end
        
        
    else
        id1 = find(ax == 0);
        if  ~isempty(id1) then
            filt_resp(id1) = (-1)./(%pi.*samp_per_symb).*(%pi.*(rollof_factor-1) - 4.*rollof_factor);
        end
        
        id2 = find(abs(abs(4.*rollof_factor.*ax) - 1.0) < sqrt(%eps));
        if ~isempty(id2) then
            filt_resp(id2) = 1 ./ (2.*%pi.*samp_per_symb) * (%pi.*(rollof_factor+1)  .* sin(%pi.*(rollof_factor+1)./(4.*rollof_factor)) - 4.*rollof_factor .* sin(%pi.*(rollof_factor-1)./(4.*rollof_factor)) + %pi.*(rollof_factor-1)   .* cos(%pi.*(rollof_factor-1)./(4.*rollof_factor)) );
        end
        
        id = 1:length(ax);
        id([id1 id2]) = [];
        nid = ax(id);
        a = (-4.*rollof_factor./samp_per_symb);
        b = ( cos((1+rollof_factor).*%pi.*nid) + sin((1-rollof_factor).*%pi.*nid) ./ (4.*rollof_factor.*nid) );
        c = (%pi .* ((4.*rollof_factor.*nid).^2 - 1));
        
        for idx = 1:length(id)
            filt_resp(id(idx)) = a*b(idx)/c(idx);
            idx
        end
        
  
    end
    
    filt_resp = filt_resp / sqrt(sum(filt_resp.^2));
    
    h = filt_resp';
    
endfunction

function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
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
        
        if ~strcmpi(properties(jdx), 'nonNegative') then
            if variable < 0 then
                error('Input should be non-negative');
            end
        end
        
        if ~strcmpi(properties(jdx), 'finite') then
            if ~(abs(variable) < %inf) then
                error('Input should be finite');
            end
        end
        
    end

endfunction


function checkStringValidity(variable, valid_strings)
        if ~strcmpi(valid_strings(1), variable) | ~strcmpi(valid_strings(2), variable) then
            
        else
            error('Input string is not recognized')
        end   
    
endfunction
