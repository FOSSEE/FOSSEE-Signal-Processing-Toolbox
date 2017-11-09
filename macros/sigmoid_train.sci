function y =sigmoid_train(t, ranges, rc)
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
