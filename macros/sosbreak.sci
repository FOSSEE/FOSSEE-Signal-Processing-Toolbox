
function [zerosort,g]=sosbreak(p)
// Function for breaking a polynomial into second-order polynomials and an extra linear term.
//
// Syntax
//   [zerosort, g] = sosbreak(p)
//
// Parameters
// p: Input polynomial (vector or symbolic polynomial).
//
// Outputs
// zerosort: List of broken polynomials. Contains second-order polynomials and possibly one linear polynomial.
// g: Integer multiple obtained after breaking the polynomial.
//
// Description
// The `sosbreak` function factors the input polynomial `p` into real-coefficient polynomials. It segregates the factors 
// into second-order polynomials and linear polynomials. If the polynomial degree is odd, the last linear polynomial is left as is. 
// For even-degree polynomials, linear factors are combined into second-order polynomials.
//
// Examples
// // Break a polynomial into second-order polynomials and a linear term:
//    v = [1 + 4 * %s + 6 * %s^2 + 4 * %s^3 + %s^4];
//    [zerosort, g] = sosbreak(v);
//
// Authors
// Parthasarathi Panda
// parthasarathipanda314@gmail.com



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
