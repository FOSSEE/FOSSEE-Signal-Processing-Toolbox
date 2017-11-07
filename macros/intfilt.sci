function [h, a]= intfilt(R, L, freqmult)
   
   
    // This function estimate Interpolated FIR Filter Design.
    // Calling Sequence
    // h=intfilt(R,L,freqmult)
    // [h a]=intfilt(R,L,freqmult)
 
    // Parameters
    // R: Samples. It should be numeric
    // L: bandlimited interpolation samples. It must be nonzero.
    // freqmult: bandlimitedness of ALPHA times the Nyquist frequency, IT can be numeric or character ('B' or 'L', B is length 
    //   (N+1)*L-1 for N odd and (N+1)*L for N even)
    
    // h:  linear phase FIR filter. 
    
    // Examples
    // h=intfilt(20,10,'l')
    // h=intfilt(20,10,1)
    //
    // See also
    // Authors
    // Jitendra Singh

    
    if or(type(R)==10) | or(type(L)==10) then
              error ('Argument R and L must be numeric.')
              
              else
    
    
    
          
         if argn(2)==3 then
                   if type(freqmult)==10 then
                             typ=freqmult;
                             n=L;
                   else
                             freqmult=double(freqmult);
                             typ='b';
                             end
  
     end
     
     if freqmult==0 then
         h=repmat(%nan,[1,(2*R*L-1)])
         a=1;
         else
     
    
     //typ(1)=='b' | typ(1)=='B'
     
         if convstr(typ(1), 'u') =='B' then
                   n=2*R*L-1;
                   
                 
                   if freqmult==1 then
                             M=[R R 0 0];
                             F= [0 1/(2*R) 1/(2*R) 0.5];
                   else
                             M=R*[1 1];
                             
                  if type(freqmult)==10 then           
               F=[0 98/2/R];
           else
               F=[0 freqmult/2/R]
               end
        
        for f=(1/R):(1/R):.5,
            
            if type(freqmult)==10 then
            F=[F f-(98/2/R) f+(98/2/R)]; 
        else
            F=[F f-(freqmult/2/R) f+(freqmult/2/R)]; 
            end
            
            M=[M 0 0];
        end;

        if (F(length(F))>.5),
            F(length(F))=.5;
        end;
    end      
        N=n-1; F=F*2; M=M
 
 
if (max(F)>1) | (min(F)<0)
    error('Frequencies in F must be in range [0,1]')
end




if ((length(F)-fix(length(F)./2).*2)~=0)
    error('Argument F should of even length');
end

if (length(F) ~= length(M))
    error('The input arguments F & A must have same length');
end


    W = ones(length(F)/2,1);
    ftype = '';


    ftype = 0;  differ = 0;


N = N+1;  
                 
F=F(:)/2;  M=M(:);  W=sqrt(W(:));  
dF = diff(F);

if (length(F) ~= length(W)*2)
    error('There should be one weight per band.');
end


if or(dF<0),
   
    error('F frequency must be increasing')
    
end



if and(dF(2:2:length(dF)-1)==0) & length(dF) > 1,
    band = 1;
else
    band = 0;
end
if and((W-W(1))==0)
    weights = 1;
else
    weights = 0;
end

L=(N-1)/2;

Nodd = N-fix(N./2).*2;


    if ~Nodd
        m=(0:L)+.5;  
    else
        m=(0:L);     
    end
  
   
    k=m';
    need_matrix = (~band) | (~weights);
    
 
    
    
    if need_matrix
             
        I1=k(:,ones(size(m,1),size(m,2)))+m(ones(size(k,1),size(k,2)),:);    
        I2=k(:,ones(size(m,1),size(m,2)))-m(ones(size(k,1),size(k,2)),:);    
        G=zeros(size(I1,1),size(I1,2));
    end

    if Nodd
        k=k(2:length(k));
        b0=0;      
    end;
    b=zeros(size(k,1),size(k,2));
    
    dd=diff(F);
    
    if or(dd==0) & R==1 then
       
        h=repmat(%nan,[1,n])
        a=1
        
        else
    for s=1:2:length(F),

        
        m=(M(s+1)-M(s))/(F(s+1)-F(s));    
        b1=M(s)-m*F(s);                   
        if Nodd
            b0 = b0 + (b1*(F(s+1)-F(s)) + m/2*(F(s+1)*F(s+1)-F(s)*F(s)))* abs(W((s+1)/2)^2) ;
        end
     
      b=b(:)
        b = b+(m/(4*%pi*%pi)*(cos(2*%pi*k*F(s+1))-cos(2*%pi*k*F(s)))./(k.*k))* abs(W((s+1)/2)^2);
            
               
            
        b = b' + (F(s+1)*(m*F(s+1)+b1)*sinf(2*k*F(s+1))- F(s)*(m*F(s)+b1)*sinf(2*k*F(s)))* abs(W((s+1)/2)^2);
        if need_matrix
               

               
               mat=matrix((.5*F(s+1)*(sinf(2*I1*F(s+1))+sinf(2*I2*F(s+1)))- .5*F(s)*(sinf(2*I1*F(s))+sinf(2*I2*F(s))) ) * abs(W((s+1)/2)^2),size(G,1),size(G,2)) ;
                mat=mat';
                G=G+mat;  
                

        end
    end;

    
    if Nodd
        b=[b0; b'];
    end;

    if need_matrix
        a=G\b;
    else
        a=(W(1)^2)*4*b;
        if Nodd
            a(1) = a(1)/2;
        end
    end
    if Nodd
        h=[a(L+1:-1:2)/2; a(1); a(2:L+1)/2].';
    else
        h=.5*[flipud(a); a].';
    end;  
     end;  
          
  //typ(1)=='l' | typ(1)=='L' 
        

        
       elseif convstr(typ(1), 'u') =='L'  then
                 
            if n==0 then
                      h=ones(1,R)
                      return 
                      end     
                 
        t=0:n*R+1;
        l=ones(n+1,length(t));
        
        for i=1:n+1
                  for j=1:n+1
                            if (j~=i) then
                                      l(i,:)=l(i,:).*(t/R-j+1)/(i-j);
                            end
                  end
        end
        
        h=zeros(1,(n+1)*R);
        
        for i=0:R-1
        for j=0:n
                  h(j*R+i+1)=l((n-j)+1,round((n-1)/2*R+i+1));
        end
end



if h(1) == 0,
        h(1) = [];
    end

else
          error ('This type of filter is not recognized.')
          
                          
         end
         a=1;
         
    
 end
 end
                            
endfunction



////// Supplementary function

function y=sinf(x)
          
     for i=1:length(x)
               if x(i)==0 then
                         y(i)=1;
                         else
               
               y(i)=sin(%pi*x(i))/(%pi*x(i));
               end
               
               end     
          
          y=y';
endfunction
