function [r, lowercrossvalue, uppercrossvalue, lowerreference, upperreference]=risetime(x, varargin)
    
      
    // This function estimate risetime values of real vector X.
    // Calling Sequence
    // r=risetime(x)
    // r=risetime(x, Fs)
    // r=risetime(x, t)
    // r=risetime(x, t, 'PercentReferenceLevels', N )
    // r=risetime(x, t, 'Tolerance', M)
    // r=risetime(x, t,'StateLevels', O)
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]=risetime(x)
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]=risetime(x, Fs)
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]=risetime(x, t)
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]=risetime(x, t, 'PercentReferenceLevels', N )
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]= risetime(x, t, 'Tolerance', M)
    // [r lowercrossvalue uppercrossvalue lowerreference upperreference]= risetime(x, t,'StateLevels', O)
    //  // [r lowercrossvalue uppercrossvalue lowerreference upperreference]= risetime(x, t,'StateLevels', O, 'fig', on or off)
    //  
    // Parameters
    // x: real vector.
    // Fs: specifies the sample rate, Fs, as a positive   scalar, where the first sample instant corresponds to a time of zero.
    // t: defiene instant sample time t as vector with same length of x, or specifies the sample rate, t, as a positive scalar.
    // PercentReferenceLevels: specify the percentreferenceleves as a percentage, default value of N is [10 90].
    // Tolerance: define the tolerance value as real scaler value, where default value of M is 2.0.
    // StateLevels:  define the lower and upper state levels as two element real vector. 
    // fig: specify the logical input value to display figure as one of 'on' or 'off', where the default input in 'off'. 
    // r: return rise time of positive-going bilevel waveform transitions X. 
    // lowercrossvalue: return the lowerc cross value.
    // uppercrossvalue: return the upper cross value.
    // lowerreference: return lower reference value corrosponding to lower percenr reference value.
    // upperreference: return lower reference value corrosponding to upper percenr reference value.
    
    // Examples
    // x=[1.2, 5, 10, -20, 12]
    //t=1:length(x)
    //r=risetime(x, t) 
    // See also
    // Authors
    // Jitendra Singh
  
    
    
  // run statelevels and midcross function before running risetime function. 
  
    if or(type(x)==10) then
    error ('Input arguments must be double.')
end  
    
    if  length(varargin)==0 then  // if the no of input is 0, then specify the default values to input parameter.
        [levels hist]=statelevels(x);
        Lvarargin=list(1:length(x), 'StateLevels', levels(1), 'MidPercentReferenceLevel', 10, 'Tolerance', 2, 'fig', 'off')
        Uvarargin=list(1:length(x), 'StateLevels', levels(2), 'MidPercentReferenceLevel', 90, 'Tolerance', 2, 'fig', 'off')
    end
    
if length(varargin)>=1 & type(varargin(1))==1 then
     if length(varargin(1))==1 then
        t=(0:(length(x)-1));
       
    elseif length(varargin(1))==length(x) then
        t=varargin(1);
        
    else
        error('T must be a same length as X.')
    end
else
    t=1:length(x);
end


if length(varargin)>=2 & type(varargin(1))==1 & type(varargin(2))==1 then
    error ("Too many leading numeric arguments (at most 2 expected).");
end




sindex=[];
if length(varargin)>=1 then
a=1;

for i=1:length(varargin)   
    if type(varargin(i))==10 then
        sindex(a)=i;
        a=a+1;
        end      
end
end


if length(sindex)>5 then
    error('Unexpected argument.')
end

if length(varargin)==1 & (isempty(sindex)) then
    
    [levels hist]=statelevels(x);
        Lvarargin=list(t, 'StateLevels', levels(1), 'MidPercentReferenceLevel', 10, 'Tolerance', 2, 'fig', 'off')
        Uvarargin=list(t, 'StateLevels', levels(2), 'MidPercentReferenceLevel', 90, 'Tolerance', 2, 'fig', 'off')

end

fig='OFF';
//////////////////////////////////

if (~isempty(sindex)) then
        for j=1:length(sindex)
            
            select convstr(varargin(sindex(j)),'u')
                
                case {'STATELEVELS'}
                   //////
                 if length(varargin) <=sindex(j) then
                      error(strcat(['parameter StateLevels required a value']));
                  end
                  
                  if type(varargin(sindex(j)+1))==1 then
                      levels=varargin(sindex(j)+1); 
                      
                   elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='PERCENTREFERENCELEVELS' |  convstr(varargin(sindex(j)+1),'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='FIG' then
                      
                    error('parameter StateLevels required a value.')        
                  
                      
                  elseif type(varargin(sindex(j)+1))==10  then
                      
                    error('Expected STATELEVELS to be one of these types: double, Instead its type was char.')
                    end

                  
                case {'PERCENTREFERENCELEVELS'}           
            if length(varargin) <=sindex(j) then
                      error(strcat(['parameter MidPercentRefernceLevel required a value.'])); 
                  end
                  
                  if  type(varargin(sindex(j)+1))==1 then
                      midpercentval= varargin(sindex(j)+1);                                                           
                        elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='STATELEVELS' | convstr(varargin(sindex(j)+1),'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='FIG' then                     
                    error('parameter MidPercentRefernceLevel required a value.') 
                                
                  elseif type(varargin(sindex(j)+1))==10 then                     
                    error('Expected MidPercentRefernceLevel to be one of these types: double, Instead its type was char.')  
                end
                              
                if length( midpercentval)~=2 then
                    error ('Expected MidPercentRefernceLevel to be of size 1x2')                                  
                end 
  /////////////////////////////////
  
                    perval=varargin(sindex(j)+1);
                    disp(perval)
                   if perval(2)<= perval(1) then
                     error('The PercentReferenceLevels must be in increasing order.')
                     end
                
                       varargin(sindex(j))='MidPercentReferenceLevel';
                     varargin(sindex(j)+1)=perval(1);
                    Lvarargin= varargin;
                    
                    varargin(sindex(j)+1)=perval(2);
                    Uvarargin=varargin;
         
                
            case {'FIG'}
                
                if length(varargin) <=sindex(j) then
                      error(strcat(['parameter fig required a value.']));
                  end
                  
                  if type(varargin(sindex(j)+1))==1 then
                      error ('Expected fig to match one of these strings: on or off');
                  
                 elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='STATELEVELS' | convstr(varargin(sindex(j)+1), 'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='PERCENTREFERENCELEVELS' then                     
                    error('parameter fig required a value.')                     
                    else 
                        fig=  convstr(varargin(sindex(j)+1), 'u');
                       
                    end 
                    
               
                     if fig == 'OFF' | fig == 'ON' then  
        else 
     error('Expected fig to match one of these strings: on or off');
           end   
  
                      
                   
        case{'ON'} 
            

            
         case{'OFF'}
                       
                case {'TOLERANCE'}
                   //disp('jitend')
            if length(varargin) <=sindex(j) then
                      error(strcat(['parameter Tolerance required a value"]));
                 
                  elseif type(varargin(sindex(j)+1))==1 then
                     tolerance= varargin(sindex(j)+1); 
                      
                  elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')== 'STATELEVELS' | convstr(varargin(sindex(j)+1), 'u')== 'PERCENTREFERENCELEVELS' | convstr(varargin(sindex(j)+1), 'u')=='FIG' then
                      
                    error('parameter Tolerance required a value.');
                                   elseif type(varargin(sindex(j)+1))==10  then
                      
                    error('Expected Tolerance to be one of these types: double, Instead its type was char.');
                    end
                                           

            
            else      
              error(strcat(['Invalid optional argument'," ", varargin(sindex(j))]));
            end // switch
        end // for
    end // if

 
 indexx=[];
if length(sindex)>=1  then
a=1;
for i=1:length(sindex)
     
  indexx(a)=find(convstr(varargin(sindex(i)), 'u')=='MIDPERCENTREFERENCELEVEL')  
    a=a+1;
end
end  


if  sum(indexx)==0 then
    
     varargin(length(varargin)+1)='MIDPERCENTREFERENCELEVEL';
           varargin(length(varargin)+1)=10;
                    Lvarargin= varargin;
                    
                    varargin(length(varargin))=90;
                    Uvarargin=varargin;   
end
   
index_on=[];

if length(sindex)>=1  then
a=1;

for i=1:length(sindex)
     
  index_on(a)=find(convstr(varargin(sindex(i)), 'u')=='ON')  
 
    a=a+1;
 
end
end  

if sum(index_on)>0 then
    Lvarargin(sindex(find(index_on>0)))='OFF';
    Uvarargin(sindex(find(index_on>0)))='OFF';
end



    
   [lcrossval lref levels t tolerance]= midcross(x, Lvarargin(:));  // calling midcross function to get lower cross values
   
    [ucrossval uref]=midcross(x, Uvarargin(:));  // calling midcross function to get upper cross values
    
    
    if length(lcrossval)==length(ucrossval) then 
        dff=ucrossval-lcrossval
        r=dff(dff>0)  
    elseif length(lcrossval)>length(ucrossval)
        n=length(ucrossval);
        dff=ucrossval-lcrossval(1:n);
        r=dff(dff>0)
    else
        n=length(lcrossval);
        dff=ucrossval(1:n)-lcrossval;
        r=dff(dff>0) 
    
 end
 
 difference=ucrossval-lcrossval;
 Pindex=find(difference>0);
 
 
    
 uppercrossvalue=ucrossval(Pindex);
 lowercrossvalue=lcrossval(Pindex);  
 
 lowerreference=lref;
 upperreference=uref; 
 
    
     upperbound= levels(2)- (tolerance/100)*(levels(2)-levels(1)); // estimating bounds
 mostupperbound=levels(2)+ (tolerance/100)*(levels(2)-levels(1));
  lowerbound= levels(1)+ (tolerance/100)*(levels(2)-levels(1));
  mostlowerbound=levels(1)- (tolerance/100)*(levels(2)-levels(1));    
    
    
 
    
    
   if fig=='ON' then   // if the defined output is only 1, the it will provide the graphical representation of                          //levels
       
      if length(r)==0 then
         
        plot(t,x, 'LineWidth',1, 'color', 'black')
      
         plot(t,upperreference * ones(1, length(t)),'-r', 'LineWidth',0.5)
   
       plot(t,lowerreference * ones(1, length(t)),'-g', 'LineWidth',0.5)
        
   
      plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
    
       
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
       xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  
       

     legends(["Signal";   "upper boundary"; "upper state"; "lower boundary"; "upper reference"; "lower reference"; "upper boundary"; "lower state"; "lower boundary"],  [[1;1], [5;2], [1;2], [5;2], [5;1], [3;1], [3;2], [1;2], [3;2]], opt='?')  
         
      else 
      
      plot(t,x, 'LineWidth',1, 'color', 'black')
      
        plot(t,upperreference * ones(1, length(t)),'-r', 'LineWidth',0.5)
   
       plot(t,lowerreference * ones(1, length(t)),'-g', 'LineWidth',0.5)
          
    rects=[lowercrossvalue; upperreference*ones(lowercrossvalue); r; (upperreference-lowerreference)*ones(r)]
   
   col=-10*ones(r);
    
    xrects(rects, col);
    
     plot(uppercrossvalue, upperreference*ones(uppercrossvalue), "r*", 'MarkerSize',15);
     
      plot(lowercrossvalue, lowerreference*ones(lowercrossvalue), "g*", 'MarkerSize',15);
      
      plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
    
       
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
       xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  
       

     legends(["risetime"; "Signal"; "upper cross"; "lower cross"; "upper boundary"; "upper state"; "lower boundary"; "upper reference"; "lower reference"; "upper boundary"; "lower state"; "lower boundary"],  [[-11; 2] , [1;1], [-10;5], [-10;3], [5;2], [1;2], [5;2], [5;1], [3;1], [3;2],[1;2], [3;2]], opt='?')

   end    
   end  
    

endfunction
