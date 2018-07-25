//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function o=cconv(a,b,n)

 // circularly convolves vectors a and b. n is the length of the resulting vector.
 //If you omit n, it defaults to length(a)+length(b)-1. When n = length(a)+length(b)-1,
 //the circular convolution is equivalent to the linear convolution computed with conv
 //Calling Sequence:
 //o=cconv(a,b)
 //o = cconv(a,b,n)
//a  =a real or complex vector.
//b  =a real or complex vector.
//n  =length of circular convolution
//o  =convolution sequence
//Examples:
//a=[1 2 3]
//b=[4 5 6]
//o=cconv(a,b,3)
//Output:  o=  31.    31.    28.
//
//
//a=[1 2+%i 4]
//b=[2 3*%i 5]
//o=cconv(a,b)
//o=clean(o)
//
//Output:  o=  2.    4. + 5.i    10. + 6.i    10. + 17.i    20.
//



    [nargout,nargin]=argn();
    if nargin==2 then //to check the number of inputs entered by the user
        n=length(a)+length(b)-1;//setting the length of convolution
    end
    if type(a)~=1 | type(b)~=1 | type(n)~=1 then//to check if the inputs are real/complex arrays
        error('check the data type of input');
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
    elseif j==1 //if a column vector make it a row vector
        a=a';
    end
    //checking if b is a 1d vector(row or column) and turning it into row vector
    [i,j]=size(b);
    if j~=1 & i~=1 then
        error('b should be a vector');
    elseif j==1//if a column vector make it a row vector
        b=b';
    end

    //adjusting length of a
    if n<=length(a) then//if length exceeds n,then take only first n-samples
        a=a(1:n);
    else//if length is less than n, then pad zeroes
        a=[a,zeros(1,n-length(a))]
    end
    //adjusting length of b
    if n<=length(b) then//if length exceeds n,then take only first n-samples
        b=b(1:n);
    else//if length is less than n, then pad zeroes
        b=[b,zeros(1,n-length(b))]
    end
    //computing ffts (for speed)
    aft=fft(a);
    bft=fft(b);
    //circular convolution dft is the product of dft of the 2
    oft=aft.*bft;
    o=ifft(oft);  //inverse gives circular covolution
endfunction
