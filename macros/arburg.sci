function varargout = arburg( x, poles, criterion )
//This function calculates coefficients of an autoregressive (AR) model of complex data.
//Calling Sequence
//a = arburg(x, poles)
//a = arburg(x, poles, criterion)
//[a, v] = arburg(...)
//[a, v, k] = arburg(...)
//Parameters 
//x: vector of real or complex numbers, of length > 2
//poles: positive integer value < length(x) - 2 
//criterion: string value, takes in "AKICc", "KIC", "AICc", "AIC" and "FPE", default it not using a model-selection criterion 
//a, v, k: Output variables
//Description
//This is an Octave function.
//
//This function calculates coefficients of an autoregressive (AR) model of complex data x using the whitening lattice-filter method of Burg.
//
//The first argument is the data sampled. The second argument is the number of poles in the model (or limit in case a criterion is supplied).
//The third parameter takes in the criterion to limit the number of poles. The acceptable values are "AIC", "AKICc", "KIC", "AICc" which are based on information theory.
//Output variable a is a list of P+1 autoregression coefficients.
//Output variable v is the mean square of residual noise from the whitening operation of the Burg lattice filter.
//Output variable k corresponds to the reflection coefficients defining the lattice-filter embodiment of the model. 
//Examples
//arburg([1,2,3,4,5],2)
//ans =
//   1.00000  -1.86391   0.95710

funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(lhs>3)
error("Wrong number of output arguments.")
elseif(rhs<2)
error("Wrong number of input arguments.")
end

	select(lhs)
	case 1 then
	if(rhs==2)
	a = callOctave("arburg",x,poles)
	elseif(rhs==3)
	a = callOctave("arburg",x,poles,criterion)
	end
	case 2 then
	if(rhs==2)
	[a,v] = callOctave("arburg",x,poles)
	elseif(rhs==3)
	[a,v] = callOctave("arburg",x,poles,criterion)
	end
	case 3 then
	if(rhs==2)
	[a,v,k] = callOctave("arburg",x,poles)
	elseif(rhs==3)
	[a,v,k] = callOctave("arburg",x,poles,criterion)
	end
	end
endfunction
