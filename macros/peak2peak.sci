function [Y] = peak2peak(X, dim)
// Compute the maximum-to-minimum difference (peak-to-peak).
//
// Syntax
//   Y = peak2peak(X)
//   Y = peak2peak(X, dim)
//
// Parameters
// X: Real or complex-valued input vector or matrix.
// dim: (optional) Dimension along which to compute the maximum-to-minimum difference.
//
// Description
// The `peak2peak` function computes the difference between the maximum and minimum values in `X`. 
// By default, it operates along the first non-singleton dimension of `X`. If the `dim` parameter is provided, 
// the computation is performed along the specified dimension.
//
// Examples
// // Compute peak-to-peak difference for a vector:
//    t = 0:0.001:1-0.001;
//    x = cos(2 * %pi * 100 * t);
//    y = peak2peak(x)
//
// // Compute peak-to-peak difference along a specific dimension:
//    t = 0:0.001:1-0.001;
//    x = (1:4)' * cos(2 * %pi * 100 * t);
//    y = peak2peak(x, 2)
//
// Authors
// Rahul Dalmia
// Debdeep Dey
	
	//function only accepts real values due to limitations of the 'max' function in Scilab
	//Modifications made by Debdeep Dey
	

	
funcprot(0);
narginchk(1,2,argn(2));

[nr, nc] = size (X);			 // Dimensions of Input calculated
if(type(X)==10) then //if i/p is a char type vector or matrix or a string
    w=X;
    [nr,nc]=size(X);
    if(nr==1 & nc==1) then
        X=ascii(X);
        X=matrix(X,length(w));
        X=X';
    else
        
        X=ascii(X);
        X=matrix(X,size(w));
    end
    
end

if (~exists('dim','local')) then
	if (nr==1) then
		Y = zeros(nr, 1); 			 // preset all output fields to 0
		for i= 1:nr
			maxim=max(X(i,:));		 // maximum and minimum values are found
			minim=min(X(i,:));
			Y(i,1)=maxim-minim;		 // Peak to peak value is calculated from the difference of max and min
		end
	else 
		Y = zeros(1, nc); 			 // preset all output fields to 0
		for i= 1:nc
			maxim=max(X(:,i));		 // maximum and minimum values are found
			minim=min(X(:,i));
			Y(1,i)=maxim-minim;		 // Peak to peak value is calculated from the difference of max and min
		end
	end

elseif (exists('dim','local')) then
    if (dim<1) then
        error("Dimension argument must be a positive integer scalar within indexing range.");
    end
	if (dim==1) then
		Y = zeros(1, nc); 			 // preset all output fields to 0
		for i= 1:nc
			maxim=max(X(:,i));		 // maximum and minimum values are found
			minim=min(X(:,i));
			Y(1,i)=maxim-minim;		 // Peak to peak value is calculated from the difference of max and min
		end

	elseif (dim==2) then 
		Y = zeros(nr, 1); 			 // preset all output fields to 0
		for i= 1:nr
			maxim=max(X(i,:));		 // maximum and minimum values are found
			minim=min(X(i,:));
			Y(i,1)=maxim-minim;		 // Peak to peak value is calculated from the difference of max and min
	    end
    else// for cases when dim >2
        Y=zeros(nr,nc);	
    
    end
end

endfunction
function narginchk(l,h,ni)
if(ni<l) then //ensure that the no. of input args is either 1 or 2
    error("Not enough input arguments");
end

if (ni>h) then
    error("Too many input arguments");
end
endfunction
