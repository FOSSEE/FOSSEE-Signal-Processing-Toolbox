function lsf=poly2lsf(a)


//poly2lsf Prediction polynomial to line spectral frequencies.

// Calling Sequence
// lsf = poly2lsf(a)
// Parameters
// k: define the prediction polynomial.
// lsf: returns corresponding line spectral frequencies.
// Examples
//
//EXAMPLE
//X=[1 0.6149 0.9899 0 0.0031 -0.0082]
// lsf = poly2lsf(X)
//EXPECTED OUTPUT:
//lsf  =0.7841731  1.5605415  1.8776459  1.8984313  2.3592523

//
// Author
// Jitendra Singh
//modified to match MATLAb o/p
if(find(a(1,1)==0)==1) then
    error ("Input to ROOTS must not contain NaN or Inf");
end //end  of modification


if or(type(a)==10) then
    error ('The polynomial must have all roots inside of the unit circle.')
end



if (size(a,1) > 1) & (size(a,2) > 1)
    error('The prediction polynomial must be stored in a vector.')
end


if ~isreal(a) then
    error('Line spectral frequencies are not defined for complex polynomials.')
end

if (max(abs(roots(a))) >= 1) then
    error('The polynomial must have all roots inside of the unit circle.');
end

if a(1) ~= 1 then
    a = a./a(1);
end

a=a(:);
p  = length(a)-1;
a1 = [a;0];
a2 = a1($:-1:1);
pp = a1-a2;
qq = a1+a2;

if (p-fix(p./2).*2)~=0 then  // Odd order
    //////////////////////////////
    aa=[1 0 -1];
    [m,n] = size(pp);
    n = max(m,n);
    na = length(aa);
    if na > n
        P = 0;

    else
        P= filter(pp, aa, [1 zeros(1,n-na)]);
        if m ~= 1
            P = P(:);
        end
    end

    Q = qq;
else          // Even order

    aa=[1 -1];
    [m,n] = size(pp);
    n = max(m,n);
    na = length
    (aa);
    if na > n
        P = 0;

    else
        P= filter(pp, aa, [1 zeros(1,n-na)]);
        if m ~= 1
            P = P(:);
        end
    end

    aa=[1 1];
    [m,n] = size(qq);
    n = max(m,n);
    na = length(aa);

    if na > n
        Q = 0;

    else
        Q= filter(qq, aa, [1 zeros(1,n-na)]);
        if m ~= 1
            Q = Q(:);
        end
    end

end

r_p  = roots(P); r_q  = roots(Q);

ap  =atan(imag(r_p(1:2:$)),real(r_p(1:2:$)));
aq  = atan(imag(r_q(1:2:$)),real(r_q(1:2:$)));

lsf = mtlb_sort([ap;aq]);
endfunction
