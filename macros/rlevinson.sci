function [R, U, kr, e] = rlevinson(a, efinal)

//rlevinson function  computes the autocorrelation coefficients using prediction polynomial.
// Calling Sequence
// a = rlevinson(a, efinal)
// [a, U] = rlevinson(a, efinal)
// [a, U, kr] = rlevinson(a, efinal)
// [a, U, kr, e] = rlevinson(a, efinal)

// Parameters
// a: input argument prediction polynomial.
// efinal: input argument 'final prediction error'.
// R: returns the autocorrelation coefficients.
// U: return a upper triangular matrox of order (length(a)*length(a))
// kr: return refelection coefficient.
// e: Return the vector of prediction error.


// Examples
//X = [7 6 5 8 3 6]     //make the first prediction polynomial coefficient unity and check for standard Auto regressive model

//X=[1 6/7 5/7 8/7 3/7 6/7];
//
// [R U kr e] = rlevinson(X, 0.3)

////EXPECTED OUTPUT:
//e  =
//
//    0.3757546    0.0221076  - 3.4125    1.1307692    0.3
// kr  =
//
//  - 0.2251908
//    0.9701364
//  - 12.464286
//  - 1.1538462
//    0.8571429
// U  =
//    1.  -0.2251908     0.9701364   -12.464286       -1.1538462    0.8571429
//    0.    1.                 -0.4436567     6.5                    2.                  0.4285714
//    0.    0.                   1.                 -12.535714     - 1.                  1.1428571
//    0.    0.                   0.                   1.                      1.8461538    0.7142857
//    0.    0.                   0.                   0.                      1.                  0.8571429
//    0.    0.                   0.                   0.                      0                   1
//
//
//
// R  =
//
//    0.3958273
//    0.0891367
//  - 0.3444604
//    0.0362590
//  - 0.1329496
//    0.1042446
//
//
// Author
// Jitendra Singh
//


      if or(type(a)==10) then
    error ('Input arguments must be numeric.')
end



    if argn(2)<2 then // checking of number of input arguments, if argn(2)<2 execute error.
              error ('Not enough input argument, define final prediction error.')
    end

          a=a(:);
          if a(1)~=1 then
                    warning('First coefficient of the prediction polynomial was not unity.')
          end

          if a(1)==0 then
              R=repmat(%nan,[length(a),1])
              xx=length(a);
              l=tril(zeros(xx,xx),-1);
              d=diag(ones(1,xx));
              u=triu(repmat(%nan,[xx,xx]),1);
              U=l+d+u;
              U(xx,xx)=%nan;
              U(1:xx-1,xx)=(repmat(%inf,[1,xx-1]))'
              kr=repmat(%nan,[xx-2,1]);
              kr=[kr',%inf]
              kr=kr'
          else



          a=a/a(1);

          n=length(a);

          if n<2 then // execute the error if the length of input vector in less than 2
          error ('Polynomial should have at least two coefficients.')
end

if type(a)==1 then // checking for argument type
         U=zeros(n,n);
end

      U(:,n)=conj(a($:-1:1)); // store prediction coefficient of order p

      n=n-1;
      e(n)=efinal;
       Kr(n)=a($); // defining the input required for next step i.e. levinson down

      a=a'
      for i=n-1:-1:1 // start levinson down

         ee=a($)

          a = (a-Kr(i+1)*flipdim(a,2,1))/(1-Kr(i+1)^2);

           a=a(1:$-1)


    Kr(i)=a($);

      econj=conj(ee) //conjugate
    econj=econj'
    e(i) = e(i+1)/(1.-(econj.*ee));



     U(:,i+1)=[conj(a($:-1:1).'); zeros(n-i,1)];   //conjugate

           end  // end of levinson down estimation
            e=e';

 if  abs(a(2))==1 then
           e1=%nan
 else
       e1=e(1)/(1-abs(a(2)^2));
 end



 U(1,1)=1;
 kr=conj(U(1,2:$))
 kr=kr';

 R1=e1;
 R(1)=-conj(U(1,2))*R1; //conjugate

 for j=2:n
     R(j)=-sum(conj(U(j-1:-1:1,j)).*R($:-1:1))- kr(j)*e(j-1);
     R=R(:);

 end

 R=[R1; R];
  end


endfunction
