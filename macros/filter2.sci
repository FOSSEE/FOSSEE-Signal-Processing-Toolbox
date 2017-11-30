function Y = filter2 (B, X, SHAPE)
//Apply the 2-D FIR filter B to X.
//Calling Sequence
//Y = filter2(B, X)
//Y = filter2(B, X, SHAPE)
//Parameters
//B, X: Matrix  
// SHAPE: 
//        'full':  pad X with zeros on all sides before filtering.
//        'same': unpadded X (default)
//        'valid': trim X after filtering so edge effects are no included. 
//Description
//This function applies the 2-D FIR filter B to X. If the argument SHAPE is specified, return an array of the desired shape.
//Examples
//filter2([1,3], [4,5])
//ans = 
//     19.    5.  
funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
        Y=callOctave("filter2",B,X)
	case 3 then
		Y = callOctave("filter2",B,X,SHAPE)
    end

endfunction
