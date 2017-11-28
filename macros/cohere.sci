function [Pxx,freqs] = cohere(x,y,Nfft,Fs,win,overlap,ran,plot_type,detrends)
	rhs= argn(2);
	lhs= argn(1);
	if(rhs < 10 | rhs > 10)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 10 then
		[Pxx,freqs] = callOctave("cohere",x,y,Nfft,Fs,win,overlap,ran,plot_type,detrends);
	end
endfunction