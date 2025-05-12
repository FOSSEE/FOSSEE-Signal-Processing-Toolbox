function R = circshift(M, d)
// Perform a circular shift on an array.
//
// Syntax
//   R = circshift(M, d)
//
// Parameters
// M: Array. Input vector or matrix of any data type.
// d: Vector of integers. Specifies the number of positions to shift along each dimension.
//    For example, d = [0, n] shifts elements by `n` positions along the columns.
// R: Array. Resulting array after the circular shift.
//
// Description
// This function circularly shifts the elements of the input array `M` by the specified positions `d` along each dimension.
//
// Examples
// M = [1, 2, 3, 4];
// circshift(M, [0, 1])
// 

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
