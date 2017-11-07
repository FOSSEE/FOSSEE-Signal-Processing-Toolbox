function zf = filtic (b, a, y, x)

//This function finds the initial conditions for the delays in the transposed direct-form II filter implementation
//Calling Sequence
//zf = filtic (b, a, y)
//zf = filtic (b, a, y, x)
//Parameters 
//b: vector of real or complex numbers 
//a: vector of real or complex numbers 
//y: vector of real or complex numbers 
//x: vector of real or complex numbers 
//Description
//This function finds the initial conditions for the delays in the transposed direct-form II filter implementation.
//The vectors b and a represent the numerator and denominator coefficients of the filter's transfer function. 
//Examples
//filtic([i,1,-i,5], [1,2,3i], [0.8i,7,9])
//ans =
//    0.00000 - 22.60000i
//    2.40000 +  0.00000i
//    0.00000 +  0.00000i
//This function is being called from Octave

funcprot(0);
rhs = argn(2)

if(rhs>4 | rhs<3)
	error("Wrong number of input agruments.")
end

select(rhs)
case 3 then
zf = callOctave("filtic",b,a,y)
case 4 then
zf = callOctave("filtic",b,a,y,x)
end
endfunction

