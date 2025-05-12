
function [phi, varargout]=phasedelay(varargin)
// Compute the phase delay of a filter.
//
// Syntax
//   [phi] = phasedelay(b, a, w)
//   [phi] = phasedelay(sos, w)
//   [phi, f] = phasedelay(..., fs)
//
// Parameters
// b: Numerator coefficients of the filter (vector).
// a: Denominator coefficients of the filter (vector).
// sos: Second-order section matrix (K x 6).
// w: Frequency points (vector) at which the phase delay is computed (in radians/sample).
// fs: (optional) Sampling frequency (scalar). If provided, the frequency vector `f` is returned in Hz.
//
// Description
// The `phasedelay` function computes the phase delay of a filter at specified frequency points. 
// It supports both direct rational form (numerator and denominator coefficients) and second-order section (SOS) form.
//
// - For direct rational form, the phase delay is computed using the numerator and denominator coefficients.
// - For SOS form, the phase delay is computed for each section and summed to obtain the total phase delay.
//
// Examples
// // Compute phase delay for a filter in direct form:
//    b = [0.1, 0.2, 0.3];
//    a = [1, -0.5, 0.25];
//    w = linspace(0, %pi, 100);
//    phi = phasedelay(b, a, w);
//
// // Compute phase delay for a filter in SOS form:
//    sos = [1, -0.5, 0.25, 0.1, 0.2, 0.3];
//    w = linspace(0, %pi, 100);
//    phi = phasedelay(sos, w);
//
// // Compute phase delay with sampling frequency:
//    b = [0.1, 0.2, 0.3];
//    a = [1, -0.5, 0.25];
//    w = linspace(0, %pi, 100);
//    fs = 1000;
//    [phi, f] = phasedelay(b, a, w, fs);
//
// Authors
// Parthasarathi Panda
// parthasarathipanda314@gmail.com

    //cas variable is 2 if sos form is involved and 1 if direct rational form is given
    //(sos,n) or (sos,w) or (sos,'whole')or (b,a) is the input
    //cas variable is 2 if sos form is involved and 1 if direct rational form is given
    //cas1 variable is 1 if f is to be given as output, 2 other wise
//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com

    [nargout,nargin]=argn();
    //do not forget to execute 'phaseInputParseAs_sos' and 'phaseInputParseAs_ab' before running
    v=size(varargin(1));
    if size(v)>2 then
        error ('invalid input dimension');
    end
    [n,k]=size(varargin(1));
    if type(varargin(1))~=1 then
        error ('check the input type');
    end
    if (n==1 & k==6) then //not clear if sos or (a,b)
        v=size(varargin(2));
        if (nargin==1) //(sos) is the input
            cas=2;
            [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
        elseif (varargin(2)=='whole') //(sos,'whole')is the input
            cas=2;
            [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
        else //taking it as (a,b)
            cas=1;
            [a,b,w,cas1,fs]=phaseInputParseAs_ab(varargin,nargin);
        end
    elseif (n==1 | k==1) then
        cas=1;
        [a,b,w,cas1,fs]=phaseInputParseAs_ab(varargin,nargin);
    elseif k==6 then //first variable is sos
        cas=2;
        [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
    end
    //cas,cas1,fs,w,[(a,b),sos]
    if cas==1 then
        [m,n]=size(a);
        N=[0:n-1];
        M=N'*w;//computing matrix Mij=(i-1)*wj
        num=(a*exp(%i*M));//the operation computes phase of sum(ak*exp(i*w*k))
        num_dot=(%i*(a.*N)*exp(%i*M));//computing the derivative on those points
        phdel_num=(imag(num_dot).*real(num)-imag(num).*real(num_dot))./(abs(num).*abs(num));
        
        [m,n]=size(b);
        N=[0:n-1];
        M=N'*w;
        den=(b*exp(%i*M));//the operation computes phase of sum(ak*exp(i*w*k))
        den_dot=(%i*(b.*N)*exp(%i*M));//computing the derivative on those points
        phdel_den=(imag(den_dot).*real(den)-imag(den).*real(den_dot))./(abs(den).*abs(den));
        phi=(phdel_num-phdel_den);
        0;
    else
        [n,k]=size(sos)
        N=[0,1,2];
        M=N'*w;
        num=(sos(:,4:6)*exp(%i*M));//the operation computes phase of sum(ak*exp(i*w*k))
        num_dot=(%i*(sos(:,4:6).*(ones(n,1)*N))*exp(%i*M));//computing the derivative on those points
        phdel_num=(imag(num_dot).*real(num)-imag(num).*real(num_dot))./(abs(num).*abs(num));
        
        den=(sos(:,1:3)*exp(%i*M));//the operation computes phase of sum(ak*exp(i*w*k))
        den_dot=(%i*(sos(:,1:3).*(ones(n,1)*N))*exp(%i*M));//computing the derivative on those points
        phdel_den=(imag(den_dot).*real(den)-imag(den).*real(den_dot))./(abs(den).*abs(den));
        
        phi_mat=phdel_num-phdel_den;
        phi=sum(phi_mat,1);//summing each of the componenet second order system phases
    end
    if cas1==1 then
        varargout(2)=w*fs/(2*%pi);
    end
endfunction
