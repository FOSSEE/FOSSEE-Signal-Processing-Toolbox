function [dboutput] = db(X, SignalType, R)

//dboutput = db(X) converts the elements of the vector or matrix X to decibels (dB). The elements of X are voltage measurements across a resistance of 1 ohm.

//dboutput = db(X,SignalType) specifies the signal type represented by the elements of X as 'voltage' or 'power'. The entries are not case sensitive. The default value is 'voltage'. For voltage measurements, the resistance defaults to 1 ohm. If you specify SignalType as 'power', the elements of X must be nonnegative.

//dboutput = db(X,R) specifies the resistance R for voltage measurements. You can specify a resistance only when the signal measurements are voltages.

//dboutput = db(X,'voltage',R) specifies the resistance R for voltage measurements. This syntax is equivalent to db(X,R).

//X - Signal measurements. X must be a vector or matrix. If the elements of X are power measurements, all elements must be nonnegative.

//SignalType - Type of signal measurements. Valid entries for SignalType are 'voltage' or 'power'. The entries are not case sensitive. If you specify SignalType as 'power', the elements of X must be nonnegative.
//Default: 'voltage'

//R - Resistive load in ohms. You can specify resistance only when the SignalType is 'voltage'.
//Default: 1

//Author : Pratik Kapoor
//Modified to remove disp(SignalType) at line 28 
//Modified to handle imaginary, negative power, and zero input
//Modifications by Debdeep Dey
funcprot(0);

[lhs, rhs] = argn(0)

[nr, nc] = size(X);
dboutput = zeros(nr, nc);

//disp(SignalType);
if rhs == 1 then
    
    R = 1;
    for i = 1: nr
        for j = 1: nc
            //handle zero i/p
            if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
            elseif abs(X(i,j))>0 then 
                dboutput(i, j) = 10 * log10((abs(X(i, j)) * abs(X(i, j))) / R);
            
            else
                dboutput(i, j) = -%inf;    
            end
        end
    end
    
elseif rhs == 2 then
    
    if (SignalType == 'voltage' | SignalType == 'Voltage' | SignalType == 'VOLTAGE') then
        R = 1;
        for i = 1: nr
            for j = 1: nc
                if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
                elseif abs(X(i,j))>0 then
                    dboutput(i, j) = 10 * log10((abs(X(i, j)) * abs(X(i, j))) / R);
                else
                    dboutput(i, j) = -%inf;
                end
            end
        end
        
    elseif(SignalType == 'power' | SignalType == 'Power' | SignalType == 'POWER') then[i, j] = size(X);
        
        R = 1;
        for i = 1: nr
            for j = 1: nc
                if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
                elseif (X(i, j)) > 0 then
                    dboutput(i, j) = 10 * log10(X(i, j));
                elseif(X(i,j)==0) then
                    dboutput(i,j)=-%inf;
                else //function should not accept negative values for power
                    
                    error("Power cannot be negative")
                end
            end
            
        end
        
    elseif(type(SignalType == 1))
        R = SignalType;
        for i = 1: nr
            for j = 1: nc
                if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
                elseif abs(X(i,j))>0 then
                    dboutput(i, j) = 10 * log10((abs(X(i, j)) * abs(X(i, j))) / R);
                else
                    dboutput(i,j)=-%inf;
                end
            end
        end
    end
    
elseif rhs == 3 then
    
    if (type(SignalType) == 1) then
        error('Incorrect argument. Argument 2 specifies the signal type represented by elements of X');
        
    elseif(SignalType == 'voltage' | SignalType == 'Voltage' | SignalType == 'VOLTAGE') then
        for i = 1: nr
            for j = 1: nc
                if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
                elseif abs(X(i,j))>0 then
                    dboutput(i, j) = 10 * log10((abs(X(i, j)) * abs(X(i, j))) / R);
                else
                    dboutput(i,j)=-%inf;
                end
            end
        end
            
            elseif(SignalType == 'power' | SignalType == 'Power' | SignalType == 'POWER') then
                
                
                for i = 1: nr
                    for j = 1: nc
                        if (type(X(i, j)))==10 then
                dboutput(i, j) = 10 * log10((ascii(X(i, j)) * ascii(X(i, j))) / R);
                        elseif (X(i, j)) > 0 then
                            dboutput(i, j) = 10 * log10(X(i, j));
                        elseif(X(i,j)==0) then
                            dboutput(i,j)=-%inf;
                        else
                            error("Power cannot be negative");
                        end
                    end
                    
                    
                    
                end
        end
        
    end
    
    endfunction
