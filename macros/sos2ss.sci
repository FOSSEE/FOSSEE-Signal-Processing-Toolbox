//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function [A,B,C,D]=sos2ss(sos,g)
    [nargout,nargin]=argn();
    if nargin==1 then
        g=1;
    end
    if type(sos)~=1 | type(g)~=1 then
        error('check the data type of input'); //to check if the inputs are real/complex arrays
    end
    if size(g)~=[1,1] then
        error('check the data type of input'); //to check that n is single dimensional
    end
    //checking if sos is a 6 column matrix
    [d,j]=size(sos);
    if j~=6 then
        error('sos should be a 6-column matrix');
    end
    
    num=[1];
    den=[1];
    //convolving the numerator and denominator to get the coefficient of the numerator and the denominator at the top and bottom
    for i=[1:d]
        num=convol(num,sos(i,1:3));
        den=convol(den,sos(i,4:6));
    end
    
    if den(t)==0 then
        error('improper transfer function check input');
    end
    
    t=2*d+1; //polynomial degree
    A=zeros(t-1,t-1);
    if t>2 then
        A(2:(t-1),1:(t-2))=eye(t-2,t-2);
    end
    A(1,:)=-1*den(2:t)/den(1); 
    B=zeros(t,1);
    B(1)=1/den(1); //constructing (A,B) in canonical controllable form

    C=g*(num(2:t)-den(2:t)*num(1)/den(1));//appropiate C and D
    D=g*num(1)/den(1);
    
endfunction
