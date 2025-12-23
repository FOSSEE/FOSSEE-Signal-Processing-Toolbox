function bw= enbw (window, fs)
// Estimate the Equivalent Noise Bandwidth (ENBW) of a window.
//
// Syntax
//   bw = enbw(window)
//   bw = enbw(window, fs)
//
// Parameters
// window: Vector. Specifies the sample window.
// fs: Positive scalar (optional). Specifies the sampling rate of the window. Default is 1.
// bw: Scalar. Returns the two-sided equivalent noise bandwidth for a uniformly sampled window.
//
// Description
// This function estimates the Equivalent Noise Bandwidth (ENBW) of a given window. The ENBW is calculated as the ratio of the root mean square (RMS) value of the window to its mean, squared. If the sampling rate `fs` is provided, the bandwidth is scaled accordingly.
//
// Examples
// // Without sampling rate:
//    window = 1:10
//    bw = enbw(window)
// // With sampling rate:
//    window = 1:10
//    fs = 2.5
//    bw = enbw(window, fs)
//
//
// Authors
//  Jitendra Singh
//

      if isreal(window) then
          else
    error ('Input arguments window should be real.')
end 

      if isvector(window) then
          else
    error ('Input arguments window should be a vector.')
end 
   
    
     if or(type(window)==10) then
    error ('Input arguments must be double.')
end 
    
    if  type (window)~=1 then
        error ('Expected input number 1, WINDOW, to be one of these types: double, single..Isntead its type was char.' )
    end
  
    rms_win= sqrt(mean(window.*window));
    
    bw = (rms_win/mean(window))^2;


if argn(2) > 1
    
      if fs<=0 then
        error ('Expected input number 2, Fs, to be positive.')
    end

    bw = bw * (fs) / length(window);
end

endfunction
