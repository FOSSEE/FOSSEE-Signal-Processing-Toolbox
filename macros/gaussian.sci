//Author: Rashmi Patankar
//This function returns a Gaussian convolution window.
//Calling Sequence
//w = gaussian (m)
//w = gaussian (m, a)
//Parameters 
//m: positive integer value
//a: integer value
//w: output variable, vector of real numbers
//Description
//This function returns a Gaussian convolution window of length m supplied as input, to the output vector w.
//The second parameter is the width measured in sample rate/number of samples and should be f for time domain and 1/f for frequency domain. The width is inversely proportional to a.
function w = gaussian(m, a)
    if nargin < 1 | nargin > 2 then
        error('gaussian: Incorrect number of input arguments');
    elseif ~(isscalar(m) & m == fix(m) & m > 0) then
        error('gaussian: M must be a positive integer');
    elseif nargin == 1 then
        a = 1;
    end

    w = exp(-0.5 * (([0:m-1]' - (m-1)/2) .* a).^2);
endfunction
