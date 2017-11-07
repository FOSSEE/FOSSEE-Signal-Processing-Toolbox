//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function o=cconv(a,b,n)
    [nargout,nargin]=argn();
    if nargin==2 then
        n=length(a)+length(b)-1;
    end
    if type(a)~=1 | type(b)~=1 | type(n)~=1 then
        error('check the data type of input'); //to check if the inputs are real/complex arrays
    end
    if size(n)~=[1,1] then
        error('check the data type of input'); //to check that n is single dimensional
    end
    if floor(n)~=n | imag(n)~=0 then
        error('check that n is an integer');//to check if n is an integer
    end
    //checking if a is a 1d vector(row or column) and turning it into row vector
    [i,j]=size(a);
    if j~=1 & i~=1 then
        error('a should be a vector');
    elseif j==1 
        a=a';
    end
    //checking if b is a 1d vector(row or column) and turning it into row vector
    [i,j]=size(b);
    if j~=1 & i~=1 then
        error('b should be a vector');
    elseif j==1 
        b=b';
    end
    
    //adjusting length of a
    if n<=length(a) then
        a=a(1:n);
    else
        a=[a,zeros(1,n-length(a))]
    end
    //adjusting length of b
    if n<=length(b) then
        b=b(1:n);
    else
        b=[b,zeros(1,n-length(b))]
    end
    //computing ffts (for speed)
    aft=fft(a);
    bft=fft(b);
    //circular convolution dft is the product of dft of the 2
    oft=aft.*bft;
    o=ifft(oft);    
endfunction
