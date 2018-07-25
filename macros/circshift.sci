
function R = circshift(M,d)

// Shifts array circularly

// CALLING SEQUENCES:
// R = circshift(M, d)
//     circularly shifts by d(i) positions components of M along its #ith dimensions

// PARAMETERS:
// M,R : vector or matrix of any data type
// d   : vector of integers. d(i) is the shift to be applied to the M's components
//        along its ith dimension.
//        for example d = [0 n] will shift element n position along column

// EXAMPLES:
// M = [1 2 3 4];
// circshift(M, [0 1])

//Output :
// ans  =
//
//    4.    1.    2.    3.



  if argn(2)==0
      error("Invalid input")
      R = []
      return
  end
  s = size(M)
  R = M
  for i=1:length(d)
    if s(i)>1
      D = pmodulo(d(i),s(i))
      if D~=0
        S = emptystr(1,length(s))+":"
        S(i) = "[s(i)-D+1:s(i) 1:s(i)-D]"
        S = strcat(S,",")
        if typeof(R) ~= "ce"
            execstr("R = R("+S+")")
        else
            execstr("R.entries = R("+S+").entries")
        end
      end
    end
  end
endfunction
