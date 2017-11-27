function [y, xm]= rceps(x)
//Produce the cepstrum of the signal x, and if desired, the minimum phase reconstruction of the signal x.
//Calling Sequence
//[y, xm] = rceps(x)
//Parameters 
//x: real or complex vector input
//Produce the cepstrum of the signal x, and if desired, the minimum phase reconstruction of the signal x. If x is a matrix, do so for each column of the matrix.
//Examples
// f0 = 70; Fs = 10000;                   # 100 Hz fundamental, 10kHz sampling rate
// a = poly (0.985 * exp (1i*pi*[0.1, -0.1, 0.3, -0.3])); # two formants
// s = 0.005 * randn (1024, 1);           # Noise excitation signal
// s(1:Fs/f0:length(s)) = 1;              # Impulse glottal wave
// x = filter (1, a, s);                  # Speech signal in x
// [y, xm] = rceps (x .* hanning (1024)); # cepstrum and min phase reconstruction
funcprot(0)
lhs= argn(1)
rhs= argn(2)

if(rhs <1 | rhs> 1 )
error("Wrong number of Input Arguments");
end

if(lhs<2 | lhs>2)
error("Wrong number of Output Arguments")
end

	[y,xm]= callOctave("rceps",x);

endfunction
