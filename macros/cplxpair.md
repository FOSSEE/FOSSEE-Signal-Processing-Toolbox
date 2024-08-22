# cplxpair
## Description
Sort the numbers z into complex conjugate pairs ordered by increasing real part.

The negative imaginary complex numbers are placed first within each pair. All real numbers (those with abs (imag (z) / z) < tol) are placed after the complex pairs.
and the resulting tolerance for a given complex pair is 100 * eps (abs (z(i))).

Signal an error if some complex numbers could not be paired. Signal an error if all complex numbers are not exact conjugates (to within tol).
Note that there is no defined order for pairs with identical real parts but differing imaginary parts
## Calling Sequence
- `zsort = cplxpair (z)`
- `zsort = cplxpair (z, tol)`
- `zsort = cplxpair (z, tol, dim)`
## Parameters:
### INPUTS
- `z`: z is a matrix or vector.
- `tol` : tol is a weighting factor which determines the tolerance of matching. The default value is 100. 
- `dim` : By default the complex pairs are sorted along the first non-singleton dimension of z. If dim is specified, then the complex pairs are sorted along this dimension.
### OUTPUTS
- `zsort` : sorted z 

## Dependencies:
ipermute
