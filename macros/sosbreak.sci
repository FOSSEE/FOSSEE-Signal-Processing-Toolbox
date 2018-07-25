//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function [zerosort,g]=sosbreak(p)
//function for breaking a polynomial in second order polynomials and an extra linear term (g)
//where
//g:-the interger multiple obtained after breaking the polynomial
//zerosort:-the array of the broken polynomials
//p:-the input polynomial


//EXAMPLE:
//v=[1+4*%s+6*%s^2+4*%s^3+%s^4];
// [zerosort,g]=sosbreak(v);
//OUTPUT:
// g  =1.
 //zerosort  =
 //   zerosort(1)
//                2
// 1 + 2s + s
// zerosort(2)
//                              2
//1.0000000 + 2s + s

//NOTE :To verify the output use coeff(zerosort(1)) and coeff(zerosort(2))

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
        zerosort(i)=q.*zerosort(i-1);//combining 2 linear polynomial into one quadratic polynomial
        zerosort(i-1)=null();//removing leftover linear polynomial

    end
endfunction
