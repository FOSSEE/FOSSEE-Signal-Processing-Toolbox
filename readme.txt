Toolbox: FOSSEE_Signal_Processing_Toolbox

Title: Signal Processing Toolbox

Summary: A Scilab toolbox providing functions for signal generation, transformation, filtering, and analysis.

Version: 0.3

Author: FOSSEE Scilab Team

Maintainer: Scilab Team <office@fossee.in>

Category: Signal Processing

Entity: FOSSEE, IIT Bombay

WebSite: https://www.fossee.in

License: GPL 2.0

ScilabVersion: >= 6.0

Date: 2025-09-13

Description:
 The FOSSEE Signal Processing Toolbox extends Scilab with a collection
 of functions for signal analysis, transformation, and synthesis. It is
 designed to help users perform common digital signal processing tasks.

 Features include:
  - Signal generation (sine, square, triangular, etc.)
  - Frequency-domain transformations (FFT, DFT, etc.)
  - Digital filtering (FIR, IIR, Butterworth, Chebyshev, etc.)
  - Convolution, correlation, and spectral analysis tools

 Target users:
  - Engineers working in communication systems and DSP
  - Researchers in audio, speech, and biomedical signal processing
  - Students learning fundamentals of signal processing

 Example usage:
   --> t = 0:0.01:1;
   --> x = sin(2*%pi*10*t);
   --> y = fft1(x);
   disp(abs(y), "FFT Magnitude:");

 This toolbox is developed and maintained by the FOSSEE team at IIT Bombay
 to support open-source software adoption in science and engineering.
