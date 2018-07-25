function outputVoltage = helperHarmonicDistortion(inputVoltage)
//helperHarmonicDistortionADC Helper function for HarmonicDistortionExample.m

//Calling Sequence
// outputVoltage=helperHarmonicDistortionAmplifier(inputVoltage)

//Description
//Analizing the harmonic distortion of a weakly non-linear system in the presence of noise.

//Example
//VmaxPk = 2;
//Fi = 2000;
//Fs = 44.1e3;
//Tstop = 50e-3;
//t = 0:1/Fs:Tstop;
//inputVmax = VmaxPk*sin(2*%pi*Fi*t);z
//outputVmax = helperHarmonicDistortionAmplifier(inputVmax);
//plot(t, outputVmax);replot([0,-2.5,0.005,2.5]);
//xlabel('Time')
//ylabel('Output Voltage')
//title('Amplifier output')

// model parameters
noiseVrms = 0.4e-6;  // RMS voltage of input noisefloor

// polynomial coefficients
a0 = 25e-3;  // dc bias (25mV)
a1 = 1;      // voltage gain
a2 = 6e-5;   // second order term
a3 = -1e-3;  // third order term
a4 = 5e-6;   // fourth order term
a5 = 1e-5;   // fifth order term

// polyval function has constant term at the end.
polyCoeff = [a5 a4 a3 a2 a1 a0];

// get number of input samples
n = size(inputVoltage,2);

// add noise at input
inputNoise = noiseVrms*rand(1,n,"normal");
distortedInput = inputVoltage + inputNoise;

// adjust input by DC bias, voltage gain and higher order terms
outputVoltage = polyval(polyCoeff, distortedInput);
endfunction
