function y = var(x,w,dim)
    
    // This function var estimate the variance of the values in X.
    // Calling Sequence
    // y=var(x)
    // y=var(x,w)
    // y=var(x,w,dim)    
    // Parameters
    // x: a vector or matrix.
    // w: weight vector W of length X, or may take the value of 0 and 1. The default value is 0. Consider only non-negative values.
    // dim: consider the variance along the dimension of X. 1 for clumun wise variamce and 2 for row wise variance.
    // y: returns the variance of the values in X.
   
    // Examples
    // x=[1.2, 5, 10, -20, 12,10,5,20,32,20];
    // w=1:10;
    // dim=2;
    // y=var(x, w, dim) ;
    // See also
    // Authors
    // Jitendra Singh
  
    if argn(2)==1 then
        
        if type(x)==10 then
            x=ascii(x)
            end
        if size(x,1)==1 |size(x,2)==1 then
                   sd=stdev(x)
               else 
                   sd=stdev(x,1)
               end
               y=sd.^2;
    end
    
  if argn(2)<=3 & argn(2)>1 then
      
      
      if size(x,1)==1 |size(x,2)==1  then
                   sd=stdev(x);
                   n=length(x);
                    y1= sd.^2;  
      if length(w)==1 & w==0 then
              y=y1;
       elseif length(w)==1 & w==1 then
        y=y1*((n-1)/n); 
    elseif length(w)==n & and(w>=0) then
          if size(x,1)~=size(w,1) then
      w=w';
      end 
        wmean=sum(x.*w)/sum(w);
        x1=(x-wmean).^2;
      
        l=length(find(w>0));
    
     
        sd=((sum(w.*x1))/(((l-1)/l)*sum(w)));
        y=(sd)*((n-1)/n);
        elseif length(w)~=size(x)& length(w)>1 then
    error ('The length of W must be compatible with X.') 
        
    else
        error('W must be a vector of nonnegative weights, or a scalar 0 or 1.')
        end
              
               else 
                   n=size(x,1)
                  sd=stdev(x,1)
                  y1=sd.^2;
       if length(w)==1 & w==0 then
              y=y1;
       elseif length(w)==1 & w==1 then
        y=y1*((n-1)/n);  
     elseif length(w)==n & and(w>=0) then
         
         for i=1:size(x,2) 
            xx=(x(:,i))
  if size(xx,1)~=size(w,1) then
      w=w';
      end                   
           wmean=sum(xx.*w)/sum(w);           
        x1=(x(:,i)-wmean).^2;
        l=length(find(w>0));
        sd(i)=sum((w.*x1)/(((l-1)/l)*sum(w)));
    end
    y=sd*((l-1)/l);
    
elseif length(w)~=size(x,1) & length(w)>1 then
    error ('The length of W must be compatible with X.') 

        else
      error('W must be a vector of nonnegative weights, or a scalar 0 or 1.')             
               
            end
            end
         
end



if argn(2)==3 then 
    
    if dim==2 then
        
        if size(x,1)==1 | size(x,2)==1 then
          
          if size(x,1)==1  then
              y=y;
          elseif size(x,2)==1 & length(w)== length(x) then
              error ('The length of W must be compatible with X.')             
          else
              y=zeros(size(x,1),size(x,2))
          end
   else    
  n=size(x,2)
                  sd=stdev(x,2)
                  y1=sd.^2;
       if length(w)==1 & w==0 then
              y=y1;
       elseif length(w)==1 & w==1 then
        y=y1*((n-1)/n);  
     elseif length(w)==n & and(w>=0) then         
         for i=1:size(x,1) 
            xx=(x(:,i))
  if size(xx,1)~=size(w,1) then
      w=w';
      end                   
           wmean=sum(xx.*w)/sum(w);           
        x1=(x(:,i)-wmean).^2;
        l=length(find(w>0));
        sd(i)=sum((w.*x1)/(((l-1)/l)*sum(w)));
    end
    y=sd*((l-1)/l);
        else
      error('The length of W must be compatible with X.')                            
            end
        end
end
 
        if dim==1 then

            
            if size(x,1)==1 | size(x,2)==1 then
            
          if size(x,2)==1  then
       
              y=y;
          elseif size(x,1)==1 & length(w)== length(x) then
              error ('The length of W must be compatible with X.')             
          else
              y=zeros(size(x,1),size(x,2))
          end 
            
         end
            
        end
       
        if dim>2 then
             if  length(w)==1  & w==1 | w==0 then
            y=zeros(size(x,1), size(x,2))
        else
             error ('The length of W must be compatible with X.')
            end
               
        end
                
        
        if dim<=0 then
            error('Dimension argument must be a positive integer scalar within indexing range.')
        end
        end

    endfunction
