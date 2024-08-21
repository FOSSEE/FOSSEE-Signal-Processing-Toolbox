# 
## Description
Estimate transfer function of system with input "x" and output "y".
Use the Welch (1967) periodogram/FFT method.
Compatible with Matlab R11 tfe and earlier.
See "help pwelch" for description of arguments, hints and references — especially hint (7) for Matlab R11 defaults.

## Calling Sequence

- `[Pxx,freq] = tfe(x,y,Nfft,Fs,window,overlap,range,plot_type,detrend)  `
### Dependencies: 
pwelch
## Examples
1. 
```scilab
t = linspace(0,10,1000); x =sin(t);y=cos(t);
tfe(x,y)
```


2.
```scilab
tfe(t,x,512,1000)
tfe(t,y,200,100,5)
```
3.
```scilab
t = linspace(1,10,1000); x =sin(t);
y = filter(0.23,x,t);
tfe(x,y,100,2000,4,0.45,"half")
```
4.
```scilab
t = linspace(1,10,1000); x =filter(0.3245,cos(t),t); y = filter(0.0034,x,sin(t));
tfe(x,y,3,2500,8,"shift","semilogy","no-strip")

```
5.
```scilab
t = linspace(1,10,1000); x =cos(t);
y = filter(0.9999,x,t);
tfe(x,y,2,200,6,0.456,"whole","squared")

```

