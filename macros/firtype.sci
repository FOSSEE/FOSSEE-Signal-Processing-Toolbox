//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function typ=firtype(b)
//This function identifies Type of linear phase FIR filter

//Calling Sequence
//t = firtype(b)

//Parameters
//t: type of an FIR filter
//b: Filter coefficients

//Description
//t = firtype(b) determines the type, t, of an FIR filter with coefficients b. t can be 1, 2, 3, or 4. The filter must be real and have linear phase.

//Examples
//b=[9.2762e-05   9.5482e-02   4.0443e-01   4.0443e-01   9.5482e-02   9.2762e-05]
//firtype(b)
//Output : 2

//b=[-1 -2 0 2 1]
//firtype(b)
//Output : 3

    if (type(b)~=1) then
        error('check input type');
    end
    v=size(b);
    if length(v)>2 then
        error('check input dimension');
    end
    if v(1)~=1 & v(2)~=1 then
        error('check input dimension');
    elseif v(2)==1
        b=b';
    end
    m=length(b);
    sym=(b-b($:-1:1))*(b-b($:-1:1))';//zero if symmetrical
    antisym=(b+b($:-1:1))*(b+b($:-1:1))';//zero if antisymmetrical
    if (sym==0) then
        if (pmodulo(m,2)==1) then
            typ=1;
        else
            typ=2;
        end
    elseif (antisym==0)
        if (pmodulo(m,2)==1) then
            typ=3;
        else
            typ=4;
        end
    else
        typ=-1;//not linear phas
    end
endfunction
