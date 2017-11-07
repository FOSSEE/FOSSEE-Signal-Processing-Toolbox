//levinson levinson- durbin algorithm
//calling syntax
//a = levinson(r)
//a = levinson(r,n)
//[a,e] = levinson(r,n)
//[a,e,k] = levinson(r,n)

// where 
// a is the coefficients of a length(r)-1 order autoregressive
//linear process
//e is the prediction error when order is n
// k is a column vector containing the reflection coefficients of length n

// Author Debdeep Dey
function [a, v_f, ref_f] = levinson (acf, p)

if ( argn(2)<1 )
    error("Too few input arguments");
    //  elseif( length(acf)<2 )
    //    error( "levinson: arg 1 (acf) must be vector of length >1\n");
elseif ( argn(2)>1 & ( ~isscalar(p) | fix(p)~=p ) )
    error( "levinson: arg 2 (p) must be integer >0\n");
elseif (isempty(acf))
    error("R cannot be empty");
else
    if ((argn(2) == 1)|(p>=length(acf)))
        p = length(acf) - 1;
    end
    if( size(acf,1)==1 & size(acf,2)>1 ) then
        acf=acf(:);
        
    end     // force a column vector
    if size(acf,1)>=1 then // handles matrix i/p
        
        acf=acf';
        a=acf;
        rows=size(acf,1);
        for i=1:rows
            acf_temp=acf(i,:);
            acf_temp=acf_temp(:);
            p=length(acf_temp)-1;
            //disp(acf_temp);
            if argn(1) < 3 & p < 100
                
                ////   Kay & Marple Eqn (2.39)
                
                R = toeplitz(acf_temp(1:p), conj(acf_temp(1:p)));
                an = R \ -acf_temp(2:p+1);
                an= [ 1, an.' ];
                v_f(i,:)= real( an*conj(acf_temp(1:p+1)) );
                a(i,:)=an;
                an=[];
                
            else
                
                ////   Kay & Marple Eqns (2.42-2.46)
                
                ref = zeros(p,1);
                g = -acf_temp(2)/acf_temp(1);
                
                an = [ g ];
                v= real( ( 1 - g*conj(g)) * acf_temp(1) );
                ref(1) = g;
                for t = 2 : p
                    g = -(acf_temp(t+1) + an * acf_temp(t:-1:2)) / v;
                    an = [ an+g*conj(an(t-1:-1:1)), g ];
                    v = v * ( 1 - real(g*conj(g)) ) ;
                    ref(t) = g;
                end
                v_f(i,:)=v;
                v=[];
                ref_f(:,i)=ref;
                an = [1, an];
                a(i,:)=an;
                an=[];
            end //end if
        end  //end for
    end
end



endfunction
