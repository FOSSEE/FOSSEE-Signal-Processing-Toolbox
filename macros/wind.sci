function w_out = wind (f, m, varargin)
//This function creates an m-point window from the function f given as input.
//Calling Sequence
//w = window(f, m)
//w = window(f, m, opts)
//Parameters
//f: string value/window name
//m: positive integer value
//opts: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers
//Description

//This function creates an m-point window from the function f given as input, in the output vector w.
//f can take any valid function as a string, for example "blackmanharris".
//Examples
//window("hanning",5)
//ans  =
//    0.
//    0.5
//    1.
//    0.5
//    0.
funcprot(0);
rhs = argn(2)
lhs = argn(1)

if(type(f)==10)          // Checking whether 'f' is string or not
    if(f=="bartlett" | f=="blackman" | f=="blackmanharris"  | f=="bohmanwin" | f=="boxcar" |...
        f=="barthannwin" | f=="chebwin"| f=="flattopwin" | f=="gausswin" | f=="hamming" |...
        f=="hanning" | f=="hann" | f=="kaiser" | f=="parzenwin" | f=="triang" |...
        f=="rectwin" | f=="tukeywin" | f=="blackmannuttall" | f=="nuttallwin")
        if(rhs<2)
            error("Wrong number of input arguments.")
        else
            c =evstr (f);
            w=c(m, varargin(:))
            if (lhs > 0)
                w_out = w;
            end
        end

    else
        error("Use proper Window name")
    end

else
    error("The first argument f that is window name should be a string")
end

endfunction
