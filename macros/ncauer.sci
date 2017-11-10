function [Zz, Zp, Zg] = ncauer(Rp, Rs, n)
//Analog prototype for Cauer filter.
//Calling Sequence
//[Zz, Zp, Zg] = ncauer(Rp, Rs, n)
//[Zz, Zp] = ncauer(Rp, Rs, n)
//Zz = ncauer(Rp, Rs, n)
//Parameters 
//n: Filter Order
//Rp: Peak-to-peak passband ripple
//Rs: Stopband attenuation
//Description
//This is an Octave function.
//It designs an analog prototype for Cauer filter of nth order, with a Peak-to-peak passband ripple of Rp and a stopband attenuation of Rs.
//Examples
//n = 5;
//Rp = 5;
//Rs = 5;
//[Zz, Zp, Zg] = ncauer(Rp, Rs, n)
//Zz =
//
//   0.0000 + 2.5546i   0.0000 + 1.6835i  -0.0000 - 2.5546i  -0.0000 - 1.6835i
//
//Zp =
//
//  -0.10199 + 0.64039i  -0.03168 + 0.96777i  -0.10199 - 0.64039i  -0.03168 - 0.96777i  -0.14368 + 0.00000i
//
//Zg =  0.0030628

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		Zz = callOctave("ncauer", Rp, Rs, n)
		elseif(lhs==2)
		[Zz, Zp] = callOctave("ncauer", Rp, Rs, n)
		elseif(lhs==3)
		[Zz, Zp, Zg] = callOctave("ncauer", Rp, Rs, n)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
