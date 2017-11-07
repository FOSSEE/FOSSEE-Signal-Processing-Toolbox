function [midcrossvalue, midreference, levels, t, tolerance, Tinput]= midcross(x, varargin)
    
    
    // This function estimate midcross values of real vector X.
    // Calling Sequence
    // midcrossvalue=midcross(x)
    // midcrossvalue=midcross(x, Fs)
    // midcrossvalue=midcross(x, t)
    // midcrossvalue=midcross(x, t, 'MidPercentReferenceLevels', N )
    // midcrossvalue=midcross(x, t, 'Tolerance', M)
    // midcrossvalue=midcross(x, t,'StateLevels', O)
    // [midcrossvalue midreference]=midcross(x)
    //  [midcrossvalue midreference]=midcross(x, Fs)
    // [midcrossvalue midreference]=midcross(x, t)
    // [midcrossvalue midreference]= midcross(x, t, 'MidPercentReferenceLevel', N )
    // [midcrossvalue midreference]= midcross(x, t, 'Tolerance', M)
    // [midcrossvalue midreference]= midcross(x, t,'StateLevels', O)
    // [midcrossvalue midreference]= midcross(x, t,'StateLevels', O, 'fig', on or off)
    //  
    // Parameters
    // x: real vector.
    // Fs: specifies the sample rate, Fs, as a positive   scalar, where the first sample instant corresponds to a time of zero.
    // t: defiene instant sample time t as vector with same length of x, or specifies the sample rate, t, as a positive scalar
    // MidPercentReferenceLevels: specify the midpercentreferenceleves as a percentage, default value of N is 50.
    // Tolerance: define the tolerance value as real scaler value, where default value of M is 2.0.
    // StateLevels:  define the lower and upper state levels as two element real vector. 
    // fig: specify the logical input value to display figure as one of 'on' or 'off', where the default input in 'off'.
    // midcrossvalues: return the midcross values
    // midreference: return the midrefence values.
    // levels: return statelevels values.
    // t: return the instant sample time.
    // tolerance: retunr the tolerance value
    // Tinput: return t value, which given as input parameter.

    // Examples
    // x=[1.2, 5, 10, -20, 12]
    //t=1:length(x)
    // midcrossvalue=midcross(x, t) 
    // See also
    // Authors
    // Jitendra Singh
 if or(type(x)==10) then
    error ('Input arguments must be double.')
end
    
 if length(x) < 2 then // checking the length of input datasat
  error('X must be a vector with more than one element.'); // if length of X is less 2, it will give error
end

 if length(varargin) >9 then // checking the length of input datasat
  error('Unexpected input/To many input'); // if length of X is less 2, it will give error
end

if length(varargin)==0 then
    t=1:length(x);
    Tinput=1:length(x);
     [levels hist]=statelevels(x); // run statelevels function before running this function
     midpercentval=50;
     tolerance=2;
     fig='off'

end

if length(varargin)>=1 & type(varargin(1))==1 then
     if length(varargin(1))==1 then
        t=(0:(length(x)-1))/varargin(1);
        Tinput=varargin(1);
    elseif length(varargin(1))==length(x) then
        t=varargin(1);
        Tinput=varargin(1);
    else
        error('T must be a same length as X.')
    end
else
    t=1:length(x);
end




if length(varargin)>=2 & type(varargin(1))==1 & type(varargin(2))==1 then
    error ("Too many leading numeric arguments (at most 2 expected).");
end


index=[];
if length(varargin)>=1 then
a=1;

for i=1:length(varargin)   
    if type(varargin(i))==10 then
        index(a)=i;
        a=a+1;
        end      
end
end


if length(index)>5 then
    error('Unexpected argument.')
end


Nindex=[];
if length(varargin)>=1 then
b=1;
 
for i=1:length(varargin)   
    if type(varargin(i))==1 then
        Nindex(b)=i;
        b=b+1;
        end      
end
end


 d=[];
if length(Nindex)>=2 then
    c=1;
   
    for k=1:(length(Nindex)-1)
     d(c)=Nindex(k+1)-Nindex(k);
     c=c+1;   
     end       
end


if length(d)>=1 then

f_one=find(d==1);

if length(f_one)>0 then
    error('Unexpected input.')
end
end



[levels hist]=statelevels(x);
 midpercentval=50;
     tolerance=2;
     fig='OFF';


if (~isempty(index)) then
        for j=1:length(index)
            
            select convstr(varargin(index(j)),'u')
                
                case {'STATELEVELS'}
                   //////
                 if length(varargin) <=index(j) then
                      error(strcat(['parameter StateLevels required a value']));
                  end
                  
                  if type(varargin(index(j)+1))==1 then
                      levels=varargin(index(j)+1); 
                      
                   elseif type(varargin(index(j)+1))==10 & convstr(varargin(index(j)+1), 'u')=='MIDPERCENTREFERENCELEVEL' |  convstr(varargin(index(j)+1),'u')== 'TOLERANCE' | convstr(varargin(index(j)+1), 'u')=='FIG' then
                      
                    error('parameter StateLevels required a value.')        
                      
                      
                  elseif type(varargin(index(j)+1))==10  then
                      
                    error('Expected STATELEVELS to be one of these types: double, Instead its type was char.')
                    end
                    
                if length(levels)~=2 then
                    error ('Expected STATELEVELS to be of size 1x2')
                      end             
               
                if levels(2)<=levels(1) then
                     error('The state levels must be in increasing order.')
                     end
                  ///////  
                  
                case {'MIDPERCENTREFERENCELEVEL'}

           
            if length(varargin) <=index(j) then
                      error(strcat(['parameter MidPercentRefernceLevel required a value.'])); 
                  end
                  
                  if  type(varargin(index(j)+1))==1 then
                      midpercentval= varargin(index(j)+1);                                                           
                        elseif type(varargin(index(j)+1))==10 & convstr(varargin(index(j)+1), 'u')=='STATELEVELS' | convstr(varargin(index(j)+1),'u')== 'TOLERANCE' | convstr(varargin(index(j)+1), 'u')=='FIG' then                     
                    error('parameter MidPercentRefernceLevel required a value.') 
                                
                  elseif type(varargin(index(j)+1))==10 then                     
                    error('Expected MidPercentRefernceLevel to be one of these types: double, Instead its type was char.')  
                end
                              
                if length( midpercentval)~=1 then
                    error ('Expected MidPercentRefernceLevel to be of size 1x1')                                  
                end 
                
                
            case {'FIG'}
                
                if length(varargin) <=index(j) then
                      error(strcat(['parameter fig required a value.']));
                  end
                  
                  if type(varargin(index(j)+1))==1 then
                      error ('Expected fig to match one of these strings: on or off');
                  
                 elseif type(varargin(index(j)+1))==10 & convstr(varargin(index(j)+1), 'u')=='STATELEVELS' | convstr(varargin(index(j)+1), 'u')== 'TOLERANCE' | convstr(varargin(index(j)+1), 'u')=='MIDPERCENTREFERENCELEVEL' then                     
                    error('parameter fig required a value.')                     
                    else 
                        fig=  convstr(varargin(index(j)+1), 'u');
                       
                    end 
                    
               
                     if fig == 'OFF' | fig == 'ON' then  
        else 
     error('Expected fig to match one of these strings: on or off');
           end   
  
                      
                   
        case{'ON'} 
            
             if length(varargin) == 1 then
                 error ('Unexpected input.')                     
            
              
            elseif type(varargin(index(j)-1))==1 then
                error ('Unexpected input.');            
            elseif convstr(varargin(index(j)-1), 'u')~='FIG' then
                error('Unexpected input');
                end
            
         case{'OFF'}
                       
            if length(varargin) == 1 then
                 error ('Unexpected input.')                     
            
              
            elseif type(varargin(index(j)-1))==1 then
                error ('Unexpected input.');            
            elseif convstr(varargin(index(j)-1), 'u')~='FIG' then
                error('Unexpected input');
                end      
                   
                             
                   //////
                case {'TOLERANCE'}
                   
            if length(varargin) <=index(j) then
                      error(strcat(['parameter Tolerance required a value"]));
                 
                  elseif type(varargin(index(j)+1))==1 then
                     tolerance= varargin(index(j)+1); 
                      
                  elseif type(varargin(index(j)+1))==10 & convstr(varargin(index(j)+1), 'u')== 'STATELEVELS' | convstr(varargin(index(j)+1), 'u')== 'MIDPERCENTREFERENCELEVEL' | convstr(varargin(index(j)+1), 'u')=='FIG' then
                      
                    error('parameter Tolerance required a value.');
                                           
                  elseif type(varargin(index(j)+1))==10  then
                      
                    error('Expected Tolerance to be one of these types: double, Instead its type was char.');
                    end
                  
                if length(tolerance)~=1 then
                    error ('Expected Tolerance to be of size 1x1');
                    
                    end 
            
            else      
              error(strcat(['Invalid optional argument'," ", varargin(index(j))]));
            end // switch
        end // for
    end // if




tolerance=tolerance;

if tolerance>=50 then
    error('Expected Toleracne to be an array with all of the values < 50.')    
end

if tolerance>= midpercentval then
    error ('The percent state level tolerance must be less than the mid/lower percent reference level.')
end


if tolerance+midpercentval>=100 then
    error('The sum of the percent state level Tolerance and the mid/upper percent reference level must be less than 100.')
end




 midref=levels(1)+ (midpercentval/100)*(levels(2)-levels(1)); 
     upperbound= levels(2)- (tolerance/100)*(levels(2)-levels(1));
 mostupperbound=levels(2)+ (tolerance/100)*(levels(2)-levels(1));
  lowerbound= levels(1)+ (tolerance/100)*(levels(2)-levels(1));
  mostlowerbound=levels(1)- (tolerance/100)*(levels(2)-levels(1)); 

   
   istate     = find(x<lowerbound | x>upperbound);
   n=length(istate);
  istatepre  = istate(1:(n-1));
  istatepost = istate(2:n);
  
  
   itrans    = find(x(istatepre) < lowerbound & upperbound < x(istatepost) | ...
                   x(istatepre) > upperbound & lowerbound > x(istatepost) );
  
  ipre      = istatepre(itrans);
  ipost     = istatepost(itrans);
  
   polarity = 2 * (x(ipre) < lowerbound) - 1;
  

  numtrans = length(itrans);
  iRMid  = zeros(numtrans, 1);
  
  
  for i = 1:numtrans // define convenience indices for compactness 
    ia = ipre(i);
    ib = ipost(i);

    if polarity(i) > 0
     // checking for first positive crossing of midrefence
      iX = find((x(ia:ib-1) <= midref & midref < x(ia+1:ib)));
     
      
      
      iRMid(i) = iX(1) + ia - 1;
    else
     // checking for negative crossing for midrefenrce
     
      iX = find(x(ia:ib-1)>= midref & midref > x(ia+1:ib));
      iRMid(i) = iX(1) + ia - 1;
    end
 end
x=x(:);
x=x';
t=t(:);
t=t';

  if numtrans > 0
    // interpolation to get instant values
    midcrossvalue=t(iRMid)+(t(iRMid+1)-t(iRMid)).*(midref-x(iRMid))./( x(iRMid+1)-x(iRMid));
    
  else
    midcrossvalue = [];
  end
  
 
     
  midreference=midref;
  
 
  if fig=='ON'  then   // if the defined output is only 1, the it will return the graphical representation of                          //levels
    
      
      
   //////
   
   if length(midcrossvalue)==0 then
        plot(t,x, 'LineWidth',1, 'color', 'black' )

plot(t,midref * ones(1, length(t)),'-r', 'LineWidth',0.5)
 plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
    
       
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
       xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  

        
        legends(["Signal";  "upper boundary"; "upper state"; "lower boundary"; "mid reference"; "upper boundary"; "lower state"; "lower boundary"],  [[1;1], [5;2], [1;2], [5;2], [5;1],  [3;2],[1;2], [3;2]], opt='?')
        
        else
       
       
       
   plot(t,x, 'LineWidth',1, 'color', 'black')
      
        plot(t,midref * ones(1, length(t)),'-r', 'LineWidth',0.5)
        
     plot(midcrossvalue, midreference*ones(midcrossvalue), "r*", 'MarkerSize',15);
     
         
      

      plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
    
       
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
       xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  
       

     legends(["Signal"; "mid cross";  "upper boundary"; "upper state"; "lower boundary"; "mid reference"; "upper boundary"; "lower state"; "lower boundary"],  [[1;1], [-10;5], [5;2], [1;2], [5;2], [5;1],  [3;2],[1;2], [3;2]], opt='?')
   //////////////   
      
      
end

   end
endfunction
