//Autoregressive all-pole model parameters — modified covariance method
//Calling Sequence-
//a = armcov(x,p)
//[a,e] = armcov(x,p)
//Parameters
//x:input signal
//p:order
//a:output of an AR system driven by white noise
//e:variance estimate
//Description
//This function uses the modified covariance method to fit a pth-order autoregressive (AR) model to the input signal x.

//Example :
//A = [1 -2.7607 3.8106 -2.6535 0.9238];
//y = filter(1,A,0.2*rand(1024,1,"normal"));
//arcoeffs = armcov(y,4)
//OUTPUT :      // since "rand" function is used, output doesn't always remains same. It differs by some amount.
//              1.  - 2.7450144    3.7762385  - 2.6201362     0.9104109    0.9104109

    function [ar_coeff, var_est] = armcov(data_in, order)

    checkNArgin(2,2, argn(2));                          // function call
    method = 'modified';
    [ar_coeff, var_est, msg] = arParEst(data_in, order, method);
    if ~isempty(msg) then
        error(msg);
    end


endfunction

function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')     // Number of input arguments should be greater than min_argin
    end

    if num_of_argin > max_argin then
        error('Too many input arguments')       // Number of input arguments should be lesserr than max_argin
    end

endfunction
