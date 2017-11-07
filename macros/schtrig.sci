function v = schtrig (x, lev, rs)
//This function implements a multisignal Schmitt triggers with lev levels supplied as input.
//Calling Sequence
//v = schtrig (x, lev)
//v = schtrig (x, lev, rs)
//Parameters 
//x: vector or matrix of real numbers
//lev: real number 
//rs: default value 1
//Description
//This is an Octave function.
//This function implements a multisignal Schmitt triggers with lev levels supplied as input.
//The argument 1 is a matrix (or a vector) and this trigger works along its first dimension. 
//Examples
//schtrig([0.2,-3,5],-4)
//ans  =
//    0.    0.    1.  

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end
if(rhs==2)
v = callOctave("schtrig", x, lev)
elseif(rhs==3)
v = callOctave("schtrig",x, lev, rs)
end

endfunction
