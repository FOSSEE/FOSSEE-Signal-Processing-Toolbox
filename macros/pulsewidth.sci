function [w, initialcross, finalcross, midreference]=pulsewidth(x, varargin)
    
     // This function estimate pulse width of real vector X.
    // Calling Sequence
    // w=pulsewidth(x)
    // w=pulsewidth(x, Fs)
    // w=pulsewidth(x, t)
    // w=pulsewidth (x, t, 'Polarity', pol)
    // w=pulsewidth(x, t, 'MidPercentReferenceLevel', N )
    // w=pulsewidth(x, t, 'Tolerance', M)
    // w=pulsewidth(x, t,'StateLevels', O)
    
    // [w initialcross finalcross midreference]=pulsewidth(x)
    // [w initialcross finalcross midreference]=pulsewidth(x, Fs)
    // [w initialcross finalcross midreference]=pulsewidth(x, t)
    // [w initialcross finalcross midreference]=pulsewidth(x, t, 'Polarity', pol)
    // [w initialcross finalcross midreference]=pulsewidth(x, t, 'MidPercentReferenceLevel', N )
    // [w initialcross finalcross midreference]= pulsewidth(x, t, 'Tolerance', M)
    // [w initialcross finalcross midreference]= pulsewidth(x, t,'StateLevels', O)
    // [w initialcross finalcross midreference]= pulsewidth(x, t,'StateLevels', O, 'fig', on or off)
    //  
    // Parameters
    // x: real vector.
    // Fs: specifies the sample rate, Fs, as a positive   scalar, where the first sample instant corresponds to a time of zero.
    // t: defiene instant sample time t as vector with same length of x, or specifies the sample rate, t, as a positive scalar.
    // Polarity: specify the polarity of the pulse as either 'positive' or 'negative', where the default value is 'positive'.
    // MidPercentReferenceLevel: specify the mid percent reference leves as a percentage, default value of N is 50.
    // Tolerance: define the tolerance value as real scaler value, where default value of M is 2.0.
    // StateLevels:  define the lower and upper state levels as two element real vector. 
    // fig: specify the logical input value to display figure as one of 'on' or 'off', where the default input in 'off'.
    // w: returns a vector of difference between the mid-crossings of the initial and final transitions of each positive-polarity pulse found in the input signal.
    // initialcross: returns a vector of initial cross values of bilevel waveform transitions X.
    // finalcross: returns a vector of final cross values of bilevel waveform transitions X.
    // midreference: return mid reference value corrosponding to mid percenr reference value.
    
    // Examples
    // x=[1.2, 5, 10, -20, 12]
    //t=1:length(x)
    //w=pulsewidth(x, t) 
    // See also
    // Authors
    // Jitendra Singh
  
      
  // run statelevels and midcross function before running risetime function.  
  
        if or(type(x)==10) then
    error ('Input arguments must be double.')
end 
 
    
    if  length(varargin)==0 then
   varargin=varargin;
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


pol='POSITIVE';
polidx=[];
fig='OFF'
index_on=[];
if (~isempty(sindex)) then
        for j=1:length(sindex)
            select convstr(varargin(sindex(j)), 'u') // validating input variable names
            case {'STATELEVELS'} 
                
                   if length(varargin) <=sindex(j) then
                      error(strcat(['parameter StateLevels required a value']));
                  end
                  
                  if type(varargin(sindex(j)+1))==1 then
                      levels=varargin(sindex(j)+1); 
                      
                   elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='MIDPERCENTREFERENCELEVEL' |  convstr(varargin(sindex(j)+1),'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='FIG' | convstr(varargin(sindex(j)+1), 'u')=='POLARITY'  then
                      
                    error('parameter StateLevels required a value.')        
                  
                      
                  elseif type(varargin(sindex(j)+1))==10  then
                      
                    error('Expected STATELEVELS to be one of these types: double, Instead its type was char.')
                end
                
                                                
                case {'MIDPERCENTREFERENCELEVEL'} 
                  
                     if length(varargin) <=sindex(j) then
                      error(strcat(['parameter MidPercentRefernceLevel required a value.'])); 
                  end
                  
                  if  type(varargin(sindex(j)+1))==1 then
                      midpercentval= varargin(sindex(j)+1);                                                           
                        elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='STATELEVELS' | convstr(varargin(sindex(j)+1),'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='FIG' | convstr(varargin(sindex(j)+1), 'u')=='POLARITY' then                     
                    error('parameter MidPercentRefernceLevel required a value.') 
                                
                  elseif type(varargin(sindex(j)+1))==10 then                     
                    error('Expected MidPercentRefernceLevel to be one of these types: double, Instead its type was char.')  
                end
                                 
                    
                             
               case {'TOLERANCE'} 
                   
                            if length(varargin) <=sindex(j) then
                      error(strcat(['parameter Tolerance required a value"]));
                 
                  elseif type(varargin(sindex(j)+1))==1 then
                     tolerance= varargin(sindex(j)+1); 
                      
                  elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')== 'STATELEVELS' | convstr(varargin(sindex(j)+1), 'u')== 'MIDPERCENTREFERENCELEVEL' | convstr(varargin(sindex(j)+1), 'u')=='FIG' | convstr(varargin(sindex(j)+1), 'u')=='POLARITY' then
                      
                    error('parameter Tolerance required a value.');
                                           
                  elseif type(varargin(sindex(j)+1))==10  then
                      
                    error('Expected Tolerance to be one of these types: double, Instead its type was char.');
                end  
                
                   
               case {'FIG'}
                
                if length(varargin) <=sindex(j) then
                      error(strcat(['parameter fig required a value.']));
                  end
                  
                  if type(varargin(sindex(j)+1))==1 then
                      error ('Expected fig to match one of these strings: on or off');
                  
                 elseif type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')=='STATELEVELS' | convstr(varargin(sindex(j)+1), 'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='MIDPERCENTREFERENCELEVEL' | convstr(varargin(sindex(j)+1), 'u')=='POLARITY' then                     
                    error('parameter fig required a value.')                     
                    else 
                        fig=  convstr(varargin(sindex(j)+1), 'u');
                       
                    end 
                    
               
                     if fig == 'OFF' | fig == 'ON' then  
        else 
     error('Expected fig to match one of these strings: on or off');
           end   
  
                      
                   
        case{'ON'} 
            index_on=sindex(j)
             if length(varargin) == 1 then
                 error ('Unexpected input.')                     
            
              
            elseif type(varargin(sindex(j)-1))==1 then
                error ('Unexpected input.');            
            elseif convstr(varargin(sindex(j)-1), 'u')~='FIG' then
                error('Unexpected input');
                end
            
         case{'OFF'}
                       
            if length(varargin) == 1 then
                 error ('Unexpected input.')                     
            
              
            elseif type(varargin(sindex(j)-1))==1 then
                error ('Unexpected input.');            
            elseif convstr(varargin(sindex(j)-1), 'u')~='FIG' then
                error('Unexpected input');
                end      
              
              
              
                   
               case{'POLARITY'}

                   if length(varargin)<=sindex(j) then
                       error ('Parameter polarity requires a value.')
                       end
                                      
                   if type( varargin(sindex(j)+1))==1 then
                       error ('POLARITY must be either ''Positive'' or ''Negative''.')
                       
                     elseif  type(varargin(sindex(j)+1))==10 & convstr(varargin(sindex(j)+1), 'u')== 'STATELEVELS' | convstr(varargin(sindex(j)+1), 'u')== 'MIDPERCENTREFERENCELEVEL' | convstr(varargin(sindex(j)+1), 'u')== 'TOLERANCE' | convstr(varargin(sindex(j)+1), 'u')=='FIG' then
                         
                         error ('Parameter polarity requires a value.')
                         
                   
                    elseif  convstr(varargin(sindex(j)+1), 'u') ~= 'POSITIVE' & convstr(varargin(sindex(j)+1), 'u')~= 'NEGATIVE' then
                      
                       error ('POLARITY must be either ''Positive'' or ''Negative''.');
                       
                   else 
                       polidx=sindex(j);                    
                   end 
                
                
               case {'POSITIVE'}
                   
                   if j==1 then
                       error(strcat(['Unexpected option:', " ", varargin(sindex(j))]));
                   elseif convstr(varargin(sindex(j)-1), 'u') ~= 'POLARITY'
                       error(strcat(['Unexpected option:', " ", varargin(sindex(j))]));
                   else
                        polinputidx= sindex(j);
                       
                        pol= convstr(varargin (sindex(j)), 'u') ;                        
                       end
                       
                       case {'NEGATIVE'}
                   
                   if j==1 then
                       error(strcat(['Unexpected option:', " ", varargin(sindex(j))]));
                   elseif convstr(varargin(sindex(j)-1), 'u') ~= 'POLARITY'
                       error(strcat(['Unexpected option:', " ", varargin(sindex(j))]));
                   else
                        polinputidx= sindex(j);
                        
                         pol= convstr(varargin (sindex(j)), 'u') ;                         
                       end    
                                           
            else      
              error(strcat(['Invalid optional argument'," ", varargin(sindex(j))]));
            end // switch
        end // for
    end // if
// 

if length(index_on)>0 then
    varargin(index_on)='OFF';    
end


if length(polidx)>0 then
    varargin(polidx)=null(); 
     varargin(polinputidx-1)=null();
end


   [crossval midref levels t tolerance]= midcross(x, varargin(:)); 
     
     upperbound= levels(2)- (tolerance/100)*(levels(2)-levels(1));
 mostupperbound=levels(2)+ (tolerance/100)*(levels(2)-levels(1));
  lowerbound= levels(1)+ (tolerance/100)*(levels(2)-levels(1));
  mostlowerbound=levels(1)- (tolerance/100)*(levels(2)-levels(1));  

  int_pos=[];
 final_pos=[];
  int_neg=[];
  final_neg=[]; 
 

if length(crossval)>=2 then

if x(1)>midref then
  
    int_pos=crossval(2:2:$);
    final_pos=crossval(3:2:$);
    int_neg=crossval(1:2:$);
    final_neg=crossval(2:2:$);

else
    
     int_pos=crossval(1:2:$);
    final_pos=crossval(2:2:$);
    int_neg=crossval(2:2:$);
    final_neg=crossval(3:2:$);
    
end

if length(int_pos)>length(final_pos) then
    int_pos=int_pos(1:($-1))
elseif length(int_neg)>length(final_neg) then
    int_neg=int_neg(1:($-1))
    end


end
 
 //////////////////////////////////////////////////////////////////////////////////////////
  
w=[];
         
      if pol=='POSITIVE' then
          w=final_pos-int_pos;
          initialcross=int_pos;
          finalcross=final_pos;
      else
          w=final_neg-int_neg;
          initialcross=int_neg;
          finalcross=final_neg;
          
      end
 
midreference=midref; // return midreference value

   if fig=='ON' then   // if the defined output is only 1, the it will provide the graphical representation of                          //levels
       

      if length(w)==0 then
          
    plot(t,x, 'LineWidth',1, 'color', 'black')
     // xtitle('', 'Time (second)','Level (Volts)' );
       plot(t,midreference * ones(1, length(t)),'-r', 'LineWidth',0.5)
 
      plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
   
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
      xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  
       

     legends(["Signal";   "upper boundary"; "upper state"; "lower boundary";  "mid reference"; "upper boundary"; "lower state"; "lower boundary"],  [[1;1], [5;2], [1;2], [5;2], [5;1], [3;2], [1;2], [3;2]], opt='?')  
         

      else 
   
      plot(t,x, 'LineWidth',1, 'color', 'black')
  
       plot(t,midreference * ones(1, length(t)),'-g', 'LineWidth',0.5)
     
    rects=[initialcross; levels(2)*ones(w); w; (levels(2)-levels(1))*ones(w)]

   col=-10*ones(w);

    midc=[initialcross, finalcross];
    midcross=gsort(midc, 'c','i' )
 
     plot(midcross, midreference*ones(midcross), "r*", 'MarkerSize',15);
  plot(t,mostupperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
      plot(t,levels(2) * ones(1, length(t)),'--k', 'LineWidth',0.5) 
      
      plot(t,upperbound * ones(1, length(t)),'--r', 'LineWidth',0.5)
      
    plot(t,midreference * ones(1, length(t)),'-r', 'LineWidth',0.5)
       
       plot(t,lowerbound *ones(1, length(t)),'--g', 'LineWidth',0.5)
       
       plot(t,levels(1) * ones(1, length(t)),'--k', 'LineWidth',0.5)
       
       plot(t,mostlowerbound * ones(1, length(t)),'--g', 'LineWidth',0.5) 
       
        xrects(rects, col);
       
       xlabel("Time (second)", "fontsize",3, "color", "black" )
     ylabel("Level (Volts)", "fontsize",3, "color", "black" )  
       

     legends(["pulsewidth"; "Signal";  "mid cross"; "upper boundary"; "upper state"; "lower boundary";  "mid reference"; "upper boundary"; "lower state"; "lower boundary"],  [[-11; 2] , [1;1], [-10;3], [5;2], [1;2], [5;2], [5;1], [3;2],[1;2], [3;2]], opt='?')

   end    
   end  
//    
//
endfunction
