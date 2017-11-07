function [kr, R0]=poly2rc(a, efinal)
    
//poly2rc function  convert prediction polynomial to reflection coefficients.
// Calling Sequence
// kr = poly2rc(a)
// [kr, R0] = rc2poly(a, efinal)

// Parameters
// a: prediction polynomial. 
// efinal: final prediction error.
// kr: Return refelection coefficient.
// R0: Return the  zero lag autocorrelation, R0.
 
// Examples
//X = [7 6 5 8 3 6]
// [kr, R0] = poly2rc(X)
//
// See also
//
// Author
// Jitendra Singh
// modified to handle empty vector as i/p by Debdeep Dey 
      if or(type(a)==10) then
    error ('Input arguments must be double.')
end  

 
 if (size(a,1) > 1) & (size(a,2) > 1)
                    error ('The prediction polynomial must be stored in a vector.')
          end
                   
    if argn(2)==1 | isempty(efinal) then
              efinal=0;
    end
          
     if length(a)<=1 then
                   kr= [];
                   R0=efinal; 
         end
         
         if a(1) ==0 then
                   error ('Leading coefficient cannot be zero.')
         end
         a=a(:)./a(1);
         
         n=length(a)-1;
         e=zeros(n,1);
         if(n>=1) then
             e(n)=efinal;
             kr(n)=a($);
             a=a';
         end
        
         if(n>=1) then  
            for j= (n-1):-1:1
    
                       ee=a($)
                     
                      a = (a-kr(j+1)*flipdim(a,2,1))/(1-kr(j+1)^2);
                                                   
                          a=a(1:$-1)
                       kr(j)=a($);
             
          econj=conj(ee)
        econj=econj'
        e(j) = e(j+1)/(1.-(econj.*ee));      
                                  
             end
             R0 = e(1)./(1-abs(kr(1))^2);    
          else
              R0=efinal;
           end          
       
             
endfunction
