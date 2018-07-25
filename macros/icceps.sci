function inv_ceps = icceps(input, remv_samp)
// ICCEPS computes the inverse cepstrum of a real-valued input. This spectrum 
// will be complex in nature
// Inputs:
//      input: Real-valued input 
//      remv_samps: Number of samples of delay to be removed
// Outputs: 
//      inv_ceps: Inverse cepstrum output

//Example
//xhat=[ 2.2428   -0.0420   -0.0210    0.0045    0.0366    0.0788    0.1386    0.2327    0.4114    0.9249]
//icc = icceps(xhat,2);
//round(icc)
//OUTPUT:
//  2   3   4   5   6   7   8   9   10  1

// Check validity of number of inout arguments
checkNArgin(1,3, argn(2));
    
// Check validity of input signal
checkInputSig(input);

// Seeting default input
if argn(2) < 2 then
    remv_samp = 0;
end
    
input_in_freq = fft(input);
tmp = exp(real(input_in_freq)+ %i*phaseFactor(imag(input_in_freq), remv_samp));
inv_ceps = real(ifft(tmp));

endfunction

function checkNArgin(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
    end
endfunction
    
function checkInputSig(incoming_sig)
    if isempty(incoming_sig)| issparse(incoming_sig)| (~isreal(incoming_sig)) then
        error('Input is not valid')
    end
endfunction
    
function y = phaseFactor(incoming_sig, delay_elmnts)
    len = length(incoming_sig);
    input_rnd = floor((len+1)/2);
    y = (incoming_sig(:).') + (%pi*delay_elmnts*(0:(len-1))/input_rnd); 
    if size(incoming_sig, 2)==1 then
        y = y';
    end
endfunction
