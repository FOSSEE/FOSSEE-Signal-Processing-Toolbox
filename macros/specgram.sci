function [S_r, f_r, t_r] = specgram(x,n,fs,window,overlap)

funcprot(0);
rhs = argn(2)

if(rhs<1 | rhs>5)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
	[S_r, f_r, t_r] = callOctave("specgram",x)
	case 2 then
	[S_r, f_r, t_r] = callOctave("specgram",x,n)
	case 3 then
	[S_r, f_r, t_r] = callOctave("specgram",x,n,fs)
	case 4 then
	[S_r, f_r, t_r] = callOctave("specgram",x,n,fs,window)
	case 5 then
	[S_r, f_r, t_r] = callOctave("specgram",x,n,fs,window,overlap)
	end
endfunction
