function [Num,Den,AllpassNum,AllpassDen] = iirlp2mb(varargin)
B = varargin(1)
A = varargin(2)
Wo = varargin(3)
Wt = varargin(4)
rhs = argn(2)
lhs = argn(1)
if(rhs < 4 | rhs > 5)
error("Wrong number of input arguments.")
end
if(rhs == 5)
Pass = varargin(5);
	if(Pass == 'pass')
       		pass_stop = -1
      	elseif(Pass == 'stop')
	        pass_stop = 1
	else
        error("Pass must be pass or stop.")
    	end
else
pass_stop = -1
end
if(Wo <= 0)
error("Wo is <= 0.")
end
if(Wo >= 1)
error("Wo is >= 1.");
end
oWt = 0;
for i = 1 : length(Wt)
    if(Wt(i) <= 0)
    error("Wt is <= 0.");
    end
    if(Wt(i) >= 1)
      error("Wt is >= 1.");
    end
    if(Wt(i) <= oWt)
      error("Wt not monotonically increasing.");
    else
      oWt = Wt(i);
    end
end
endfunction

