function outputVoltage = helperHarmonicDistortionAmplifier(inputVoltage)
//helperHarmonicDistortionADC Helper function for HarmonicDistortionExample.m

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




