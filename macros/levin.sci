function [ar, sigma2,rc] = levin(r);
//    //[ar,sigma2,rc]=lev(r)
//    //Resolve the Yule-Walker equations:
//    //
//    //       |r(0)   r(1)   ... r(N-1)|| a(1) | |sigma2|
//    //       |r(1)   r(0)   ... r(n-1)|| a(2) | |  0   |
//    //       |  :      :    ...    :  ||   :  |=|  0   |
//    //       |  :      :    ...    :  ||   :  | |  0   |
//    //       |r(N-1) r(N-2) ...  r(0) ||a(N-1)| |  0   |
//    //
//    //using Levinson's algorithm.
//    //  r      :Correlation coefficients
//    //  ar     :Auto-Regressive model parameters
//    //  sigma2 :Scale constant
//    //  rc     :Reflection coefficients
if length(r)==1 then
    ar=1;
    sigma2=r;
    rc=[];
    else
    


    ar = 0;
    aj(1) = 1;
    ej = r(1);  
    rc = [];
     p=length(r)-1
 
   
    for j=1:p,
        aj1 = zeros(j+1, 1);
        aj1(1) = 1;
        gammaj = r(j+1);
        for i=2:j,
            gammaj = gammaj + aj(i)*r(j-i+2);
        end
        if ej==0  then
            lambdaj1=%nan
        else
            lambdaj1 = -gammaj/ej; 
        end
       
        rc=[rc; lambdaj1];
    
        for i=2:j,
            aj1(i) = aj(i)+lambdaj1*(aj(j-i+2)');
        end
        aj1(j+1) = lambdaj1;
        ej1 = ej*(1-abs(lambdaj1)^2);
     
        aj = aj1;
        ar = aj1;
        ej = ej1;
    end
    sigma2 = sqrt(ej1);
    end
    endfunction
