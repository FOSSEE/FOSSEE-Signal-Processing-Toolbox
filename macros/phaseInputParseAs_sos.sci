function [sos,w,cas1,fs]=phaseInputParseAs_sos(arg,nargin)
    fs=0;
    if nargin<1 then
        error('no. of inputs not valid');
    end
    sos=arg(1);
    if nargin==1 then //(sos) is the input
        w=[0:(1/512):(511/512)]*%pi;
        cas1=1;
    elseif nargin==2 then //(sos,n) or (sos,w) or (sos,'whole')
        cas1=1;
        v=size(arg(2));
        if type(arg(2))==10 then
            if arg(2)=='whole' then
                n=512;
                w=[0:(1/n):((n-1)/n)]*(2*%pi);
                cas1=1;
            else
                error('invalid input');
            end
        elseif (type(arg(2))==1)
            if (v==[1,1])&(floor(arg(2))==arg(2))&(arg(2)>0) then //i.e. the entry is a single integer
                n=arg(2);
                w=[0:(1/n):((n-1)/n)]*(%pi);
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=arg(2);
            elseif (v(2)==1) then //w to row matrix
                w=(arg(2))';
            else
                error ('dimension of input is invalid');
            end
        else 
            error ('invalid input');
        end
    elseif nargin==3 then //(sos,n,fs) or (sos,f,fs) or (sos,n,'whole')
        if type(arg(3))==10 then
            cas1=1;
            if (arg(3)=='whole') then
                v=size(arg(2));
                if (v==[1,1])&(floor(arg(2))==arg(2))&(arg(2)>0) then //i.e. the entry is a single integer
                    n=arg(2);
                    w=[0:(1/n):((n-1)/n)]*(2*%pi);
                else
                    error ('dimension of input is invalid');
                end
            else
                error('invalid input');
            end
        elseif (type(arg(3))==1) then
            v=size(arg(3));
            if v~=[1,1] then
                error ('dimension of input is invalid');
            end
            cas1=2;
            fs=arg(3);
            v=size(arg(2));
            if (v==[1,1])&(floor(arg(2))==arg(2))&(arg(2)>0) then //i.e. the entry is a single integer
                n=arg(2);
                w=[0:(1/n):((n-1)/n)]*(%pi);
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=2*arg(2)*%pi/fs;
            elseif (v(2)==1) then //w to row matrix
                w=2*%pi*(arg(2))'/fs;
            else
                error ('dimension of input is invalid');
            end
        else
            error ('input type is invalid');
        end
        elseif nargin==4 //(sos,n,fs,'whole') or (sos,f,fs,'whole')
        if arg(4)=='whole' then
            v=size(arg(3));
            if v~=[1,1] then
                error ('dimension of input is invalid');
            end
            cas1=2;
            v=size(arg(2));
            if (v==[1,1])&(floor(arg(2))==arg(2))&(arg(2)>0) then //i.e. the entry is a single integer
                n=arg(2);
                [0:(1/n):((n-1)/n)]*(2*%pi);
            elseif (v(1)==1) then //(sos,w) w must be one dimensional
                w=2*arg(2)*%pi/fs;
            elseif (v(2)==1) then //w to row matrix
                w=2*%pi*(arg(2))'/fs;
            else
                error ('dimension of input is invalid');
            end
        else
            error ('input format is invalid');
        end
    end
    endfunction
