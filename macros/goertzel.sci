function Y = goertzel(X,INDVEC,DIM)
//Computes DFT using the second order Goertzel Algorithm
//Calling Sequence
//Y = goertzel(X,INDVEC,DIM)
//Parameters
//X
//A vector matrix or n-dimensional array
//INDVEC
//The indices at which the DFT is to be computed
//DIM
//The dimension along which the algorithm is to be implemented
//Description
//goertzel(X,INDVEC)
//Computes the DFT of X at indices INDVEC using the second order algorithm along
//the first non-singleton dimension. Elements of INDVEC must be positive integers
//less than the length of the first non-singleton dimension. If INDVEC is empty
//the DFT is computed at all indices along the first non-singleton dimension
//goertzel(X,INDVEC,DIM)
//Implements the algorithm along dimension DIM
//In general goertzel is slower than fft when computing the DFT for all indices
//along a particular dimension. However it is computationally more efficient when
//the DFT at only a subset of indices is desired
//Example
//x=rand(1,5)
//x  =
// 
//    0.6283918    0.8497452    0.6857310    0.8782165    0.0683740  
//y=goertzel(x,2);
//y  =
// 
//  - 0.3531539 - 0.6299881i  
//Author
//Ankur Mallick
//References
//Goertzel, G. (January 1958), "An Algorithm for the Evaluation of Finite Trigonometric Series", American Mathematical Monthly 65 (1): 34–35, doi:10.2307/2310304
    funcprot(0);
    if(argn(2)<3|isempty(DIM))
        DIM=find(size(X)>1,1); //First non-singleton dimension
    end
    if(DIM>ndims(X))
        error('Invalid Dimensions');
    end
    perm=[DIM, 1:DIM-1, DIM+1:ndims(X)];
    X=permute(X,perm); //Makes DIM the leading dimension
    S=size(X);
    if(argn(2)<2|isempty(INDVEC))
        INDVEC=1:S(1);
    end
    if(max(INDVEC)>S(1)|min(INDVEC)<1)
        error('Index out of bounds');
    elseif(or(INDVEC~=round(INDVEC)))
        error('Indices must be integers');
    end
    X1=matrix(X,1,prod(S));
    T=[type(X1), type(INDVEC), type(DIM)]; //all inputs should be of type double
    if(~and(T==1))
        error('Invalid data type');
    end
    //Implementing Goertzel algorithm
    len=[length(INDVEC), S(2:length(S))];
    Y=matrix(zeros(1,prod(len)),len);
    v=ones(length(INDVEC),1);
    w=(2*%pi*(INDVEC-1)/S(1))';
    re=2*cos(w);
    im=sin(w);
    for i=1:prod(S(2:length(S)))
        x=X(:,i)
        sp1=0;
        sp2=0;
        for j=1:S(1)
            s=x(j)*v+re.*sp1-sp2;
            sp2=sp1;
            sp1=s;
        end
        Y(:,i)=((re/2)+im*%i).*sp1-sp2;
    end
    iperm(perm)=1:length(perm);
    Y=permute(Y,iperm); //Converting Y to the original shape of X
endfunction
