function [r,p,f,m]=residued(b,a)

// Finds the partial fraction expansion of filter H(z)= B(z)/A(z).
// Calling Sequence
//	[r,p,f,m]=residued(b,a)
// Parameters
//	b: Real or complex valued vector or matrix
//	a: Real or complex valued vector or matrix
// Description
//	This is an Octave function.
//	Similar to the "residuez" function. The difference being in the function "residuez", the IIR part (poles p and residues r) is driven in parallel with the FIR part(f) whereas in the function "residued", the IIR part is driven by the output of the FIR part. In signal modeling applications, this structure can be more accurate.
// Examples
// 1.	[a,b,c,d]=residued([1 i;3 -4],[1 2; 3 4])
//	a =  [ 0.19405 - 1.31377i;   0.08329 + 0.99163i;  -0.27734 + 0.32215i]
//	b =  [ -0.10184 - 1.19167i;  -0.10184 + 1.19167i;  -2.79632 - 0.00000i]
//	c =  1
//	d =  [ 1 ; 1 ; 1]

funcprot(0);
rhs=argn(2);
if (rhs<2) then
	error ("Wrong number of input arguments.")
else	[r,p,f,m]=callOctave("residued",b,a)
end
endfunction
