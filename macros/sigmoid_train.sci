function y =sigmoid_train(t, ranges, rc)
// Evaluate a train of sigmoid functions at T.
//Calling Sequence
//y = sigmoid_train(t, ranges, rc)
//Parameters
//t: integer
//ranges: matrix
//Description
//The number and duration of each sigmoid is determined from RANGES. Each row of RANGES represents a real interval, e.g.  if sigmoid 'i' starts at 't=0.1' and ends at 't=0.5', then 'RANGES(i,:) = [0.1 0.5]'.  The input RC is an array that defines the rising and falling time constants of each sigmoid.  Its size must equal the size of RANGES.
//Examples
//sigmoid_train(0.1,[1:3],4)
//ans = 
//     0.27375
funcprot(0);
rhs=argn(2);
if (rhs<3 | rhs>3) then
    error("Wrong number of input arguments");
end

select(rhs)
case 3 then
    y=callOctave("sigmoid_train", t, ranges, rc)
end
endfunction
