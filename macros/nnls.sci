function x = nnls(E,f,x)
    // Non Negative Least Squares (nnls) for Ex=f with the constraint x>=0
    
    // Reference 
    //      Lawson, C.L. and R.J. Hanson, Solving Least Squares Problems,
    //      Prentice-Hall, 1974, Chapter 23, p. 161.
    
    m2 = size(E,1);
    n = size(E,2);
    
    iterMax = 3*n;
    
    
    x = zeros(n,1);
    z = zeros(n,1);
    w = zeros(n,1);
    wActive = w;
    // P indicates if a variable is inactive
    P = x~=0; // setting all to False
    
    // z indiactes if a variable is active
    Z = x==0; // setting all to True
    
    Ep = zeros(size(E));
  
    // Step 2
    w = E'*(f-E*x);
    
    iter = 0;
    while or(Z) & or(w(Z)>0)
        // Step 4
        wActive(P) = -%inf;
        wActive(Z) = w(Z);
        [maxval,maxindex] = max(wActive);
        
        // Step 5
        P(maxindex) = %T;
        Z(maxindex) = %F;
        
        // Step 6
        z(P)=E(:,P)\f;
        z(Z)=0;
        
        while or(z(P)<=0)
            iter = iter+1;
            if iter>iterM`ax then
                x = z;
                return;
            end
            // Step 8
            Q = (z <= 0) & P;
            
            // Step 9
            alpha = min(x(P)./(x(P)-z(P)));
            
            // Step 10
            x = x+alpha*(z-x);
            
            indices = find(x>=0);
            P(indices) = %T;
            W(indices) = %F;
            
            // Step 6
            z(P)=E(:,P)\f;
            z(Z)=0;
        end
        x = z;

        // Step 2
        w = E'*(f-E*x);
        wActive = w(Z);
    end
    
endfunction
