function [p,num]=seqperiod(x)
//Calculates the period of a sequence
//Calling Sequence
//[p,num]=seqperiod(x)
//Parameters
//x: A vector matrix or n-dimensional array
//Description
//[p,num]=seqperiod(x)
//Returns an integer p such that x(1:p) is the smallest subsequence that repeats in x
//The number of times the subsequence repeats is returned in num (may not be an integer)
//Repetitions may be incomplete at the end of the sequence but no breaks are permitted between repetitions
//If there is no subsequence that repeats in x then p=length(x)
//If x is a matrix or n-dimesnional array, the function operates along the first non-singleton dimension of x
//Examples
//x = [4 0 1 5; 
//     1 1 2 5; 
//     2 0 3 5; 
//     3 1 1 5];
//p = seqperiod(x)
//p  =
// 
//    4.    2.    3.    1.
//A=zeros(4,1,4);
//A(:,1,:)=x;
//p1=seqperiod(A);
//p1  =
//
//(:,:,1)
//
//4.  
//(:,:,2)
//
//2.  
//(:,:,3)
//
//3.  
//(:,:,4)
//
//1.  
//Authors
//Ankur Mallick
    funcprot(0);
    if(argn(2)~=1)
        error('Incorrect number of input arguments.');
    else
        S=size(x);
        S1=S(S>1);
        if(length(S1)==1)
            u=0,v=0;
            x=matrix(x,S1,1);
            for i=1:S1
                if(S1>=2*i)
                    L=ceil((S1-i)/i);
                    v=matrix(x(1:i)*ones(1,L),i*L,1);
                    u=x(i+1:S1);
                    v=v(1:length(u));
                else
                    u=x(i+1:S1);
                    v=x(1:length(u));
                end
                if(v==u|i==S1)
                    p=i;
                    num=S1/p;
                    break;
                end
            end
        else
            x1=squeeze(x);
            S2=size(x1);
            p=zeros(sum(x1,1)); //summing x along first dimension gives p a leading singleton dimensionn
            num=zeros(p); 
            for i=1:prod(S2(2:length(S2)))
                [p1,num1]=seqperiod(x1(:,i));
                p(i)=p1; //Linear indexing
                num(i)=num1; //Linear indexing
            end
            p=matrix(p,[1,S(2:length(S))]);
            num1=matrix(num,[1,S(2:length(S))]);
        end
    end
endfunction
