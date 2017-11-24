function x= synthesis(Y,C)
//Compute a signal from its short-time Fourier transform
//Calling Sequence
//X= synthesis(Y,C)
//Parameters 
//Y: Shirt-time fourier transform
//C: 3-element vector C specifying window size, increment, window type.
//Description
//Compute a signal from its short-time Fourier transform Y and a 3-element vector C specifying window size, increment, and window type.
//The values Y and C can be derived by
//[Y, C] = stft (X , ...)
funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs<2 | rhs >2)
	error("Wrong number of input arguments");
end

select(rhs)
	case 2 then
            x= callOctave("synthesis", Y,C);

end
endfunction
