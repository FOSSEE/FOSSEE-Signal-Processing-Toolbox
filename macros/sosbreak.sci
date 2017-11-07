//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function [zerosort,g]=sosbreak(p)
//function for breaking a polynomial in second order polynomials (and an extra linear)
    [zero,g]=factors(p);//factorising into real coefficient polynomials
    degn=degree(p);
    zerosort=list();
    //to segregate linear and quadratic factors
    for i=[1:length(zero)]
        q=zero(i);
        //putting the quadratic factor at the front
        if degree(q)==2 then
            zerosort(0)=q;
        //putting the linear factor at the end
        else
            zerosort($+1)=q;
        end
    end
    
    if (modulo(degn,2))==0 then
        e=length(zerosort);
    //leave the last linear element if an odd degree polynomial
    else
        e=length(zerosort)-1;
    end
    for i=[e:-2:1]
        q=zerosort(i);
        if degree(q)==2 then
            break;
        end
        zerosort(i)=q*zerosort(i-1);//combining 2 linear polynomial into one quadratic polynomial
        zerosort(i-1)=null();//removing leftover linear polynomial
    end
endfunction
