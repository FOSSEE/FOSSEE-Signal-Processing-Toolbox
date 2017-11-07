//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function typ=firtype(b)
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
