function [b, r] = deconv (y, a)
// calling sequence:
// [b,r]= deconv (y, a)
// Deconvolve two vectors.
//
// [b, r] = deconv (y, a) solves for b and r such that
// y = conv (a, b) + r.
//
// If y and a are polynomial coefficient vectors, b will
// contain the coefficients of the polynomial quotient and r will be
// a remainder polynomial of lowest order.

//Test cases:
//1.
//[b, r] = deconv ([3, 6, 9, 9], [1, 2, 3])
//Output:
//b=[3, 0]
//r=[0, 0, 0, 9]

//2.
//[b, r] = deconv ([3, 6], [1; 2; 3])
//Output:
//b  =  0.
//r= [- 2. ; 8]





    [nargout,nargin]=argn();

    if (nargin ~= 2)
        error ("wrong number of input arguments");
    end

    if (~ (isvector (y) & isvector (a)))
        error ("deconv: both arguments must be vectors");
    end

    la = length (a);
    ly = length (y);

    lb = ly - la + 1;

    // Ensure A is oriented as Y.
    if (diff (size (y)) * diff (size (a)) < 0)
        a = permute (a, [2, 1]);
    end

    if (ly > la)
        o=size (y) - size (a) + 1;
        x = zeros (o(1),o(2));
        x(1) = 1;
        b = filter (real(y), real(a), x);
    elseif (ly == la)
        b = filter (real(y), real(a), 1);
    else
        b = 0;
    end

    lc = la + length (b) - 1;
    if (ly == lc)
        if (length(a)==length(b) | length(a)>length(b))
            if isrow(a)
                q=conv(a,b);

                u=[];
                for i=1:length(y)
                    u=[u;q];
                end

                w=[];
                if (isrow(y))
                for i=1:length(q)
                    w=[w;y];
                end
            else
                for i=1:length(q)
                    w=[w,y];
                    end
            end

                r = w-u;

                r=diag(r);
            end
        end
     r=y-conv(a,b);


elseif(la~=lc)
    // Respect the orientation of Y"
    if (size (y,"r") <= size (y,"c"))
        r = [(zeros (1, lc - ly)), y] - conv (a, b);
    else
        r = [(zeros (lc - ly, 1)); y] - conv (a, b);
    end
    if (ly < la)
        // Trim the remainder is equal to the length of Y.
        r = r($-(length(y)-1):$);
    end
end

endfunction
