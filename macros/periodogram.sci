function [d,n]=periodogram(a,b,c,d,e)
    funcprot(0);
    [nargout,nargin]=argn();
    select nargin
    case 1 then
        [d,n]=callOctave('periodogram',a);
    case 2 then
        [d,n]=callOctave('periodogram',a,b);
    case 3 then
        [d,n]=callOctave('periodogram',a,b,c);
    case 4 then
        [d,n]=callOctave('periodogram',a,b,c,d);  
    case 5 then
        [d,n]=callOctave('periodogram',a,b,c,d,e);    
    else
        error("Incorrect no. of Input Arguments");
    end

endfunction

