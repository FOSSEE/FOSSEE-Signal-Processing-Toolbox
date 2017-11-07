function x = zerocrossing (w, y)
//This function estimates the points at which a given waveform crosses the x-axis.
//Calling Sequence
//x = zerocrossing (w, y)
//Parameters 
//w: 
//y:
//x:
//Description
//This is an Octave function.
//This function estimates the points at which a given waveform y = y(w) crosses the x-axis. It uses linear interpolation.
//Examples


funcprot(0);
rhs = argn(2)
if(rhs~=2)
error("Wrong number of input arguments.")
end
x = callOctave("zerocrossing", w, y)

endfunction
