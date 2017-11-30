function [PKS, LOC, EXTRA] = findpeaks(DATA, varargin)
//This function find peaks on DATA.
//Calling Sequence
//[PKS, LOC, EXTRA] = findpeaks(DATA)
//[PKS, LOC, EXTRA] = findpeaks(..., PROPERTY, VALUE)
//[PKS, LOC, EXTRA] = findpeaks(..., "DoubleSided")
//Description
//Peaks of a positive array of data are defined as local maxima. For double-sided data, they are maxima of the positive part and minima of the negative part. DATA is expected to be a single column vector.
//
//The function returns the value of DATA at the peaks in PKS. The index indicating their position is returned in LOC.
//
//The third output argument is a structure with additional information:
//
//"parabol":
//          A structure containing the parabola fitted to each returned peak. The structure has two fields, "x" and "pp". The field "pp" contains the coefficients of the 2nd degree polynomial and "x" the extrema of the intercal here it was fitted.
//
//"height":
//          The estimated height of the returned peaks (in units of DATA).
//
//"baseline":
//          The height at which the roots of the returned peaks were calculated (in units of DATA).
//
//"roots":
//        The abscissa values (in index units) at which the parabola fitted to each of the returned peaks crosses the "baseline" value. The width of the peak is calculated by 'diff(roots)'.
//
//This function accepts property-value pair given in the list below:
//
//"MinPeakHeight":
//                Minimum peak height (positive scalar). Only peaks that exceed this value will be returned. For data taking positive and negative values use the option "DoubleSided". Default value '2*std (abs (detrend (data,0)))'.
//
//"MinPeakDistance":
//                  Minimum separation between (positive integer). Peaks separated by less than this distance are considered a single peak.  This distance is also used to fit a second order polynomial to the peaks to estimate their width, therefore it acts as a smoothing parameter.  Default value 4.
//
//"MinPeakWidth":
//               Minimum width of peaks (positive integer). The width of the peaks is estimated using a parabola fitted to the neighborhood of each peak.  The neighborhood size is equal to the value of "MinPeakDistance". The width is evaluated at the half height of the peak with baseline at "MinPeakHeight". Default value 2.
//
//"DoubleSided":
//               Tells the function that data takes positive and negative values. The base-line for the peaks is taken as the mean value of the function.  This is equivalent as passing the absolute value of the data after removing the mean.
funcprot(0);
rhs=argn(2);
lhs=argn(1)
if(rhs<1 | rhs>2) then
    error("Wrong number of input arguments.");
end
if(lhs<3 | lhs>3) then
    error("Wrong number of output arguments.");
end

select(rhs)
case 1 then
    [PKS, LOC, EXTRA] = callOctave("findpeaks", DATA);
case 2 then
    [PKS, LOC, EXTRA] = callOctave("findpeaks", DATA, varargin(1));
case 3 then
    [PKS, LOC, EXTRA] = callOctave("findpeaks", DATA, varargin(1), varargin(2));
end

endfunction
