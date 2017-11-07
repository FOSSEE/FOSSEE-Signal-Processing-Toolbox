function c = clustersegment(s)
//This function calculates boundary indexes of clusters of 1’s.
//Calling Sequence
//c = clustersegment(s)
//Parameters 
//s: scalar, vector or matrix of real numbers (clusters of 1s) 
//c: output variable, cell array of size 1 by N, where N is the number of rows in s
//Description
//This is an Octave function.
//This function calculates boundary indexes of clusters of 1’s.
//This function calculates the initial and end indices of the sequences of 1's present in the input argument.
//The output variable c is a cell array of size 1 by N, where N is the number of rows in s and each element has two rows indicating the initial index and end index of the cluster of 1's respectively. The indexing starts from 1.
//Examples
//y = clustersegment ([0,1,0,0,1,1])
//y  =
//    2.    5.  
//    2.    6.  

funcprot(0);
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end

c = callOctave("clustersegment", s)

endfunction
