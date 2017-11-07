function bw= enbw (window, fs)
    
    
       
    // This function estimate Equivalent noise bandwidth.
    // Calling Sequence
    // bw=enbw(window)
    // bw=enbw(window, fs) 
    //  
    // Parameters
    // window: specify the sample window.
    // fs: specify the sampling rate of window.
    // bw: returns the two-sided equivalent noise bandwidth for a uniformly sampled window 
    
    // Examples
    // window=1:10
    //fs=2.5
    //bw=enbw(window, fs)
    // See also
    // Authors
    // Jitendra Singh
    
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
