//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
//the function is for application on vectors only
function [f,g,zo]=latcfilt(k,x,v,zi,dim)
    [nargout,nargin]=argn();
    //(k,x)
    if nargin==2 then
        v=[zeros(length(k)-1,1);1];
        zi=zeros(length(k),1);
    //(k,x,v)
    elseif nargin==3 then
        zi=zeros(length(k),1);
        //making sure k is not a matrix
        [m,n]=size(k);
        if m~=1 & n~=1 then
            error('k cannot be a matrix');
        end
    //(k,x,v,zi)
    elseif nargin==4
        [m,n]=size(k);
        if m~=1 & n~=1 then
            error('k cannot be a matrix');
        end
    //(k,x,v,zi,dim)
    elseif nargin==5
        if dim==2 then
            x=x';
        end
        [m,n]=size(k);
        if m~=1 & n~=1 then
            error('k cannot be a matrix');
        end
    else
        error('check input format');
    end
    
    //making sure they are all real or complex matrices
    if type(k)~=1 | type(x)~=1 | type(v)~=1 | type(zi)~=1 then
        error('wrong input data type');
    end
    //sanitising v
    [m,n]=size(v);
    if m==1 then
        v=v';
    elseif m~=1 & n~=1
        error('v cannot be a matrix');
    end
    if length(v)~=(length(k)+1) then
        error('dimension mis-match between k and v');
    end
    //sanitising zi
    [m,n]=size(zi);
    if m==1 then
        zi=zi';
    elseif m~=1 & n~=1
        error('zi cannot be a matrix');
    end
    if length(zi)~=(length(k)) then
        error('dimension mis-match between zi and k');
    end
    //if k is row vector make it a column vector
    [m,n]=size(k);
    if m==1 then
        k=k';
    end
    //if x is row vector make it a column vector
    [m,n]=size(x);
    if m==1 then
        x=x';
    end
    [m,n]=size(x);
    [mk,nk]=size(k);
    //when x and k are both matrices
    if nk>1 & n>1 then
        if nk==n then
            f=[];g=[];zo=[];
            for i=[1:n]
                [f1,g1,zo1]=latcfilt1(k(:,i),x(:,i),v,zi);
                f=[f,f1];
                g=[g,g1];
                zo=[zo,zo1];
            end
        else
            error('the number of columns of k and x must match');
        end
    //k is a vector
    elseif nk==1
        f=[];g=[];zo=[];
        for i=[1:n]
           [f1,g1,zo1]=latcfilt1(k,x(:,i),v,zi);
           f=[f,f1];
           g=[g,g1];
           zo=[zo,zo1];
        end
    //k is a column
    elseif n==1
        f=[];g=[];zo=[];
        for i=[1:nk]
           [f1,g1,zo1]=latcfilt1(k(:,i),x,v,zi);
           f=[f,f1];
           g=[g,g1];
           zo=[zo,zo1];
        end
    end
    
endfunction
