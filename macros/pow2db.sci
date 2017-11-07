//POW2DB   Power to dB conversion
//YDB = POW2DB(Y) convert the data Y into its corresponding dB value YDB
//Example:
//Calculate ratio of 2000W to 2W in decibels
//y1 = pow2db(2000/2)     //Answer in db
//Author : Debdeep Dey
function [ydb]=pow2db(y)
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end
[r,c]=size(y);
if (find(real(y(:))<0))==[] then
    if abs(y(:))>=0 then
     for i=1:r
            for j=1:c
                if abs(y(i,j))>0 then
                    ydb(i,j)=10*log10(y(i,j));
                else 
                    ydb(i,j)=-%inf;
                end
            end 
        end

    
    end
else
        error("The power value must be non-negative")
end

endfunction

