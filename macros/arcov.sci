function [ar_coeff, var_est] = arcov(data_in, order)
// Autoregressive all-pole model parameters — covariance method.
//
// Syntax
//   a = arcov(x, p)
//   [a, e] = arcov(x, p)
//
// Parameters
// x: Input signal.
// p: Order of the autoregressive model.
// a: Contains normalized estimates of the AR system parameters, A(z), in descending powers of z.
// e: Variance estimate of the white noise input to the AR model.
//
// Description
// Function arcov() estimates the autoregressive (AR) model parameters using the covariance method. 
// The function returns the AR coefficients `a` and the variance estimate `e` of the white noise input to the AR model.
//
// Examples
// [a, e] = arcov([1, 2, 3, 4, 5], 2)

    checkNArgin(2,2, argn(2));
    if type(data_in)==10 then
        error("Input should not be of type char");
    end
    method = 'covariance';
    [ar_coeff, var_est, msg] = arParEst(data_in, order, method);
    if ~isempty(msg) then
        error(msg);
    end
    
    
endfunction

function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
    end
        
endfunction
