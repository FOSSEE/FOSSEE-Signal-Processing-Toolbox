function strips(x,sd,Fs,scale)
//Plots vector or matrix in strips
//Calling Sequence
//strips(x);
//strips(x,sd);
//strips(x,sd,fs);
//strips(x,sd,fs,scale);
//Parameters
//x
//A vector or a matrix
//sd
//Strip duration
//fs
//Sampling frequency
//scale
//Scaling parameter for vertical axis
//Description
//strips(x)
//Plots a vector x in horizontal strips of length 250
//If x is a matrix, it plots each column of x on a separate strip with the leftmost
//column as the topmost strip
//strips(x,sd)
//Plots x in strips of length sd samples each
//strips(x,sd,fs)
//Plots x in strips of duration sd seconds with sampling frequency fs (in Hz)
//strips(x,sd,fs,scale)
//Plots x in strips as above, and scales the vertical axis by scale
//If x is a matrix, strips uses a column vector of all the elements of x for the strip plot
//If x has complex entries, only the real part of those entries are considered
//Author
//Ankur Mallick
    funcprot(0);
    if(argn(2)<1|argn(2)>4)
        error('Incorrect number of input arguments.');
    else
        if(or(imag(x)~=0))
            warning('Only real parts will be considered');
            x=real(x);
        end
        S=size(x);
        if(min(S)==1)
            x=x(:);
            S=size(x);
        end
        if(argn(2)<4)
            scale=1
        end
        if(argn(2)<3)
            Fs=1;
        end 
        if(argn(2)<2)
            if(min(S)==1)
                sd=250;
            else
                sd=S(1);
            end
        end
        Lstrip=ceil(sd*Fs); //Length of each strip
        if(pmodulo(S(1),Lstrip)==1)
            x=x(1:S(1)-1,:);  //If only 1 point is left in each row, then it is discarded
            S=size(x);
        end
        Nstrip=ceil(S(1)/Lstrip);
        x1=x(~isnan(x));
        xmin=min(x1(:));
        xmax=max(x1(:));
        x0=(xmin+xmax)/2;
        x=scale*x;
        //adding NaNs
        if (Lstrip*Nstrip>S(1)) 
            x(S(1)+1:Lstrip*Nstrip,:)=%nan*ones(Lstrip*Nstrip-S(1),S(2));
        end
        //Computing vertical deviations to add to x
        del=(xmax-xmin)/4
        sep =5*(xmax-xmin)/4;
        if(sep == 0)
            sep = 1; 
        end
        dev=(Nstrip-1:-1:0)*sep;
        y=zeros((Lstrip+1)*Nstrip,S(2));
        for i = 1:S(2)
            y1=[matrix(x(:,i),Lstrip,Nstrip); %nan*ones(1,Nstrip)];
            //Adding vertical deviation to x
            y1=y1-x0+dev(ones(Lstrip+1,1),:);
            y(:,i) = y1(:);
        end
        //Computing horizontal (time) axis
        t=[((0:Lstrip-1)'/Fs)*ones(1,Nstrip); %nan*ones(1,Nstrip)];
        t = t(:);
        //Computing yticks and yticklabels
        yt=((0:Nstrip-1)*sep)';   //yticks
        width=32;
        s1=ones(Nstrip, width)*ascii(' ');
        s=matrix(char(s1(:)),Nstrip,width);
        col=width+1;
        for i=1:Nstrip
            str=string((i-1)*sd);
            str1=(strsplit(str))'
            s(i,width-length(str)+1:width)=str1;
            col=min(col,width-length(str)+1);
        end
        s=s($:-1:1,:)
        s=char(s(:,col:width)); //yticklabels
        //Plotting and setting axes properties
        figure
        plot(t,y)
        a=gca();
        a.y_ticks=tlist(['ticks','locations','labels'],yt,s)
        a.data_bounds=[0,xmin-x0-del;sd,xmin-x0+sep*Nstrip];
        a.tight_limits='on';
        a.grid=[-1,1]
    end
endfunction
