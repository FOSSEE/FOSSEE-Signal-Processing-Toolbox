function [a,b,w,cas1,fs]=phaseInputParseAs_ab(arg,nargin)
    fs=0;
    if nargin<2 then
        error('no. of inputs not valid');
    end
    v=size(arg(2));
    if size(v)>2 then
        error ('invalid input dimension');
    end
    a=arg(1);
    b=arg(2);
    [n,k]=size(arg(2))
    if nargin==2 then //(a,b) is the input
        w=[0:(1/512):(511/512)]*%pi;
        cas1=1;
    elseif nargin==3 then //(a,b,n) or (a,b,w) or (a,b,'whole')
        cas1=1;
        v=size(arg(3));
        if type(arg(3))==10 then
            if arg(3)=='whole' then
                n=512;
                w=[0:(1/n):((n-1)/n)]*(2*%pi);
                cas1=1;
            else
                error('invalid input');
            end
        elseif (type(arg(3))==1)
            if (v==[1,1])&(floor(arg(3))==arg(3))&(arg(3)>0) then //i.e. the entry is a single integer
                n=arg(3);
                w=[0:(1/n):((n-1)/n)]*%pi;
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=arg(3);
            elseif (v(2)==1) then //w to row matrix
                w=(arg(3))';
            else
                error ('dimension of input is invalid');
            end
        else
            error ('invalid input');
        end
    elseif nargin==4 then //(a,b,n,fs) or (a,b,f,fs) or (a,b,n,'whole')
        if type(arg(4))==10 then
            cas1=1;
            if (arg(4)=='whole') then
                v=size(arg(3));
                if (v==[1,1])&(floor(arg(3))==arg(3))&(arg(3)>0) then //i.e. the entry is a single integer
                    n=arg(3);
                    w=[0:(1/n):((n-1)/n)]*(2*%pi);
                else
                    error ('dimension of input is invalid');
                end
            else
                error('invalid input');
            end
        elseif (type(arg(4))==1) then
            v=size(arg(4));
            if v~=[1,1] then
                error ('dimension of input is invalid');
            end
            cas1=2;
            fs=arg(4);
            v=size(arg(3));
            if (v==[1,1])&(floor(arg(3))==arg(3))&(arg(3)>0) then //i.e. the entry is a single integer
                n=arg(3);
                w=[0:(1/n):((n-1)/n)]*(%pi);
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=2*arg(3)*%pi/fs;
            elseif (v(2)==1) then //w to row matrix
                w=2*%pi*(arg(3))'/fs;
            else
                error ('dimension of input is invalid');
            end
        else
            error ('input format is invalid');
        end
    elseif nargin==5 //(a,b,n,fs,'whole') or (a,b,f,fs,'whole')
        if arg(5)=='whole' then
            v=size(arg(4));
            if v~=[1,1] then
                error ('dimension of input is invalid');
            end
            cas1=2;
            v=size(arg(3));
            if (v==[1,1])&(floor(arg(3))==arg(3))&(arg(3)>0) then //i.e. the entry is a single integer
                n=arg(3);
                w=[0:(1/n):((n-1)/n)]*(2*%pi);
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=2*arg(3)*%pi/fs;
            elseif (v(2)==1) then //w to row matrix
                w=2*%pi*(arg(3))'/fs;
            else
                error ('dimension of input is invalid');
            end
        else
            error ('input format is invalid');
        end
    end
    //so that a,b are row vectors
    [n,k]=size(a);
    if k==1 then
        a=a';
    end
    [n,k]=size(b);
    if k==1 then
        b=b';
    end
endfunction
