function a=lsf2poly(lsf)
//lsf2poly function  convert line spectral frequencies to prediction polynomial.
// Calling Sequence
// a = lsf2poly(lsf)

// Parameters
// lsf: define line spectral frequencies.
// a: Return the prediction polynomial.

// Examples
//X = [0.5 0.752 1.6 1.8 2.45 0.8]
// a = lsf2poly(X)
//
// See also
//
// Author
// Jitendra Singh
//  

if isempty(lsf) then
          a=[];
          else
 
      if or(type(lsf)==10) then
    error ('Input arguments must be double.')
end  

 
 if ~isreal(lsf) then
     error ('Line spectral frequencies must be real.')
 end
 
 if max(lsf)>%pi | min(lsf)<0 then
     error ('Line spectral frequencies must be between 0 and pi.')
  end
  
  
  if size(lsf,1)==1 & size(lsf,2) then
            
            error('Input should be vector of length more than one or matrix.')
            end

  
   if isvector(lsf) then
       lsf=lsf(:);
   end
   lsf1=lsf;
   n=size(lsf1);
   c=n(2);  
   for i=1:c
       lsf2=lsf1(:,i);
       lsf2=lsf2(:);
       nn=length(lsf2);
       ImgReal=exp(%i*lsf2);

       odd=ImgReal(1:2:$);
       even=ImgReal(2:2:$);

       odd1=[odd; conj(odd)];
       even1=[even; conj(even)];
  
       odd2= poly(odd1, 'x');
       odd2=real(odd2);
       odd2=flipdim(coeff(odd2), 2,1);
       even2= poly(even1,'x');
       even2=real(even2);
       even2=flipdim(coeff(even2),2, 1);

       
       if (nn-fix(nn./2).*2)~=0 then
           even3=conv(even2, [1 0 -1]);
           odd3=odd2;
        
       else
           odd3=conv(odd2, [1 1]);
           even3=conv(even2, [1 -1]);
       end
       aa=0.5*(odd3+even3);
       aa($)=[];
       aaa(i,:)=aa;
   end
   a=aaa;
   end
  
endfunction
