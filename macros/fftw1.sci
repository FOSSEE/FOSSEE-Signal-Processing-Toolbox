function res = fftw1(a, b)
//Manage FFTW wisdom data.
//Calling Sequence
// method = fftw ("planner")
//fftw ("planner", method)
//wisdom = fftw ("dwisdom")
//fftw ("dwisdom", wisdom)
//fftw ("threads", nthreads)
//nthreads = fftw ("threads")
//Parameters
//Description
//This is an Octave function.
//Wisdom data can be used to significantly accelerate the calculation of the FFTs, but implies an initial cost in its calculation. When the FFTW libraries are initialized, they read a system wide wisdom
//file (typically in /etc/fftw/wisdom), allowing wisdom to be shared between applications other than Octave. Alternatively, the fftw function can be used to import wisdom. For example,
//
//wisdom = fftw ("dwisdom")
//will save the existing wisdom used by Octave to the string wisdom. This string can then be saved to a file and restored using the save and load commands respectively. This existing wisdom can be re 
//imported as follows
//
//fftw ("dwisdom", wisdom)
//If wisdom is an empty string, then the wisdom used is cleared.
//
//During the calculation of Fourier transforms further wisdom is generated. The fashion in which this wisdom is generated is also controlled by the fftw function. There are five different manners in which 
//the wisdom can be treated:
//
//"estimate"
//Specifies that no run-time measurement of the optimal means of calculating a particular is performed, and a simple heuristic is used to pick a (probably sub-optimal) plan. The advantage of this method 
//is that there is little or no overhead in the generation of the plan, which is appropriate for a Fourier transform that will be calculated once.
//
//"measure"
//In this case a range of algorithms to perform the transform is considered and the best is selected based on their execution time.
//
//"patient"
//Similar to "measure", but a wider range of algorithms is considered.
//
//"exhaustive"
//Like "measure", but all possible algorithms that may be used to treat the transform are considered.
//
//"hybrid"
//As run-time measurement of the algorithm can be expensive, this is a compromise where "measure" is used for transforms up to the size of 8192 and beyond that the "estimate" method is used.
//
//The default method is "estimate". The current method can be queried with
//
//method = fftw ("planner")
//or set by using
//
//fftw ("planner", method)

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
	res = callOctave("fftw",a)

	case 2 then
	res = callOctave("fftw",a, b)
	end
endfunction
