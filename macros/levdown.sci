function [a,e]=levdown(a, efinal)

    
                   ee=a($);
                 
                  a = (a-a($)*flipdim(a,2,1))/(1-a($)^2);
                                               
                      a=a(1:$-1)
                  
         
      econj=conj(ee);
    econj=econj';
    e = efinal/(1.-(econj.*ee));      
                              
endfunction
