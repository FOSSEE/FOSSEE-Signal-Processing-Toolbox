function [Zb, Za, Zg]= bilinear(Sb,varargin)
// Transform a s-plane filter specification into a z-plane specification
//Calling Sequence
// [ZB, ZA] = bilinear (SB, SA, T)
// [ZB, ZA] = bilinear (SZ, SP, SG, T)
// [ZZ, ZP, ZG] = bilinear (...)
//Description
//Transform a s-plane filter specification into a z-plane specification.  Filters can be specified in either zero-pole-gain or transfer function form.  The input form does not have to match the output form.  1/T is the sampling frequency represented in the z plane.
//
//Note: this differs from the bilinear function in the signal processing toolbox, which uses 1/T rather than T.
//
//Theory: Given a piecewise flat filter design, you can transform it from the s-plane to the z-plane while maintaining the band edges by means of the bilinear transform. This maps the left hand side of the s-plane into the interior of the unit circle. The mapping is highly non-linear, so you must design your filter with band edges in the s-plane positioned at 2/T tan(w*T/2) so that they will be positioned at w after the bilinear transform is complete.
//Examples
//[ZB,ZA]=bilinear([1],[2,3],3)
	funcprot(0);
	lhs= argn(1);
	rhs= argn(2);
	if(rhs < 3 | rhs > 4)
		error("Wrong number of input arguments");
	end
	if(lhs < 2 | lhs > 3)
		error("Wrong number of output arguments");
	end
	select(rhs)
	case 3 then
		select(lhs)
		case 2 then
			[Zb, Za]= callOctave("bilinear", Sb, varargin(1), varargin(2));
		case 3 then
			[Zb, Za, Zg]= callOctave("bilinear", Sb, varargin(1), varargin(2));
		end
	case 4 then
		select(lhs)
		case 2 then
			[Zb, Za]= callOctave("bilinear", Sb, varargin(1), varargin(2), varargin(3));
		case 3 then
			[Zb, Za, Zg]= callOctave("bilinear", Sb, varargin(1), varargin(2), varargin(3));
		end
	end
endfunction		