function [PXX, FREQ] = mscohere (X, Y, WINDOW, OVERLAP, NFFT, FS, RANGE)
//It estimate (mean square) coherence of signals x and y. 
//Calling Sequence
//[Pxx, freq] = mscohere (x, y)
//[Pxx, freq] = mscohere (x, y, window)
//[Pxx, freq] = mscohere (x, y, window, overlap)
//[Pxx, freq] = mscohere (x, y, window, overlap, Nfft)
//[Pxx, freq] = mscohere (x, y, window, overlap, Nfft, Fs)
//[Pxx, freq] = mscohere (x, y, window, overlap, Nfft, Fs, range)
//mscohere (...)
//Description
//This function estimate (mean square) coherence of signals x and y. 
//Examples
//[Pxx, freq] = mscohere(4,5)
//ans =
//PXX = 
//    Nan
//     1
//FREQ =
//     0
//     0.5
funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 7)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==0)
		callOctave("mscohere",X,Y)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y)
		else
		error("Wrong number of output arguments.")
		end

	case 3 then
		if(lhs==0)
		callOctave("mscohere",X,Y,WINDOW)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y,WINDOW)
		else
		error("Wrong number of output arguments.")
	       	end
	case 4 then
		if(lhs==0)
		callOctave("mscohere",X,Y,WINDOW,OVERLAP)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y,WINDOW,OVERLAP)
		else
		error("Wrong number of output arguments.")
	       	end
	case 5 then
		if(lhs==0)
		callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT)
		else
		error("Wrong number of output arguments.")
	       	end
	case 6 then
		if(lhs==0)
		callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT,FS)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT,FS)
		else
		error("Wrong number of output arguments.")
	       	end
	case 7 then
		if(lhs==0)
		callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT,FS,RANGE,)
		elseif(lhs==2)
		[PXX, FREQ] = callOctave("mscohere",X,Y,WINDOW,OVERLAP,NFFT,FS,RANGE)
		else
		error("Wrong number of output arguments.")
	       	end
	end
endfunction

