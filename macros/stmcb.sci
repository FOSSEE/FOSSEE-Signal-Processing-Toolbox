//Compute linear model using Steiglitz-McBride iteration
//calling syntax
//[b,a] = stmcb(h,nb,na)
//[b,a] = stmcb(y,x,nb,na)
//[b,a] = stmcb(h,nb,na,niter)
//[b,a] = stmcb(y,x,nb,na,niter)
//[b,a] = stmcb(h,nb,na,niter,ai)
//[b,a] = stmcb(y,x,nb,na,niter,ai)
//b,a : coefficients of the system b(z)/a(z)
//h:impulse response of the system
//x,y: input and output of same length given to the system
//niter: no of iterations
//ai:initial estimate of the denominator coefficients
//Accepts only real i/ps , imaginary i/ps are not accepted due to limitations of the 'filter' function in Scilab
function [b,a] = stmcb( x, u_in, q, p, niter, a_in )
    
     narginchk(3, 6, argn(2));
    //modify stmcb to handle exceptions when i/p is char
    if(type(x)==10 | type(u_in)==10) then
        error("Input in stmcb must be double/single, instead it was char");
    end
    if length(u_in) == 1 then
        if argn(2) == 3 then
            niter = 5;
            p = q;
            q = u_in;
            a_in = prony(x, 0, p);
             
        elseif argn(2) == 4
            niter = p;
            p = q;
            q = u_in;
            a_in = prony(x, 0, p);
            
        elseif argn(2) == 5
            a_in = niter;
            niter = p;
            p = q;
            q = u_in;
                   
        end
        [x_row, x_col] = size(x);
        u_in = zeros(x_row, x_col); 
        u_in(1) = 1;
        
    else
        if length(u_in) ~= length(x) then
            error('Input Signal x and Output Signal Y must have the same length');
        end
        
        if argn(2) < 6 then
            [b, a_in] = prony(x, 0, p);
        end
        
        if argn(2) < 5 then
            niter = 5;     
        end
        
    end
    
    a = a_in;
    N = length(x);
    
    for i = 1:niter
        u = filter(1, a, x);
        v = filter(1, a, u_in);
        C1 = convmtx(u(:),p+1);
        C2 = convmtx(v(:),q+1);
        T = [ -C1(1:N,:) C2(1:N,:)];
        c = T(:,2:p+q+2)\(-T(:,1)); 
        a = [1; c(1:p)];
        b = c(p+1:p+q+1); 
        
    end
    
    a = a.';
    b = b.';  
    
    
    
endfunction

function narginchk(min_argin, max_argin, num_of_argin)
    if num_of_argin < min_argin then
        error('Not enough input arguments')
    end
    
    if num_of_argin > max_argin then
        error('Too many input arguments')
    end
        
endfunction
