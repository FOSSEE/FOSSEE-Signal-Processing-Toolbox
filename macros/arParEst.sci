function [model_est, var_est, msg_strg] = arParEst(data_in, order, method)
    
    checkNArgin(3, 3, argn(2))
    
    model_est = [];
    var_est   = [];
    
    if isvector(data_in) then
        data_in = data_in(:);
    end
    
    select method
    case 'covariance' then
        x_min_len = 2*order;
    case 'modified' then
        x_min_len = (3*order)/2;
    else 
        msg_strg = 'Error in function arParEst: Unknown estimation method'
        return;
    end
    
    if size(data_in, 1)< x_min_len   then
        if (strcmp(method, 'covariance') == 0) then
            if isvector(data_in) then
                msg_strg = 'length of input vector should be greater than 2 times of the input order of the model'
                return
            else 
                msg_strg = 'number of rows in input matrix should be greater than 2 times of the input order of the model'
                return
            end
        
        elseif (strcmp(method, 'modified') == 0) then
            if isvector(data_in) then
                msg_strg = 'length of input vector should be greater than 3/2 times of the input order of the model'
                return
            else 
                msg_strg = 'number of rows in input matrix should be greater than 3/2 times of the input order of the model'
                return  
            end
        end
    end
    
    if issparse(data_in) then
        msg_strg = 'Input data should not be sparse';
        return
    end
    
    if isempty(order) | order ~= round(order) then
        msg_strg = 'Model order should be an integer';
        return
    end
    
    msg_strg = [];
    model_est = zeros((order + 1), size(data_in, 2));
    var_est = zeros(1, size(data_in, 2));  
    
    for i = 1: size(data_in, 2)
        data_corrmtx = corrmtx(data_in(:, i), order, method);
        data_allcols = data_corrmtx(:, 2:size(data_corrmtx,2));
        data_sincol = data_corrmtx(:, 1);
    
        model_est(:, i) = [1; -data_allcols\data_sincol];
        
        var_tmp = data_sincol'*data_allcols;
        var_est(:, i) = data_sincol'*data_sincol + var_tmp*model_est(2:size(model_est, 1), i);
        
        var_est(:, i) = abs(real(var_est(:, i)));         
    end
    
    model_est = model_est.';
    
    
endfunction
function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
    end
        
endfunction
