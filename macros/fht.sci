function y=fht(d,n,dim)
//The Function calculates the Fast Hartley Transform of real input.
//Calling Sequence
//M = fht (D)
//M = fht (D, N)
//M = fht (D, N, DIM)
//Parameters 
//Description
//This function calculates the Fast Hartley transform of real input D. If D is a matrix, the Hartley transform is calculated along the columns by default.
//Examples
//fht(1:4)
//ans =
//   10   -4   -2   0  
//This function is being called from Octave.
funcprot(0);
rhs=argn(2);
if(rhs<1 | rhs>3)
    error("Wrong number of input arguments.")
end
select(rhs)
case 1 then
    y=callOctave("fht",d)
case 2 then
    y=callOctave("fht",d,n)
case 3 then
    y=callOctave("fht",d,n,dim)
end

endfunction
