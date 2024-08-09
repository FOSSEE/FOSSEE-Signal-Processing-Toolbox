function [ b, a ] = pei_tseng_notch ( frequencies, bandwidths )
//Return coefficients for an IIR notch-filter.
//Calling Sequence:
//[b, a] = pei_tseng_notch(frequencies, bandwidths)
//Parameters:
//frequencies: Real scalar/vector representing filter frequencies.
//bandwidths: Real scalar scalar/vector representing bandwidths to be used with filter.
//Description:
//THis function returns coefficients for an IIR notch-filter with one or more filter frequencies and according bandwidths.
//The filter is based on a all pass filter that performs phasereversal at filter frequencies. This leads to removal of those frequencies of the original and phase-distorted signal.
//Examples:
//sf = 800; sf2 = sf/2;
//data = [[1;zeros(sf-1,1)],sinetone(49,sf,1,1),sinetone(50,sf,1,1),sinetone(51,sf,1,1)];
//[b,a] = pei_tseng_notch ( 50 / sf2, 2/sf2 )
//b = 0.99213  -1.83322   0.99213
//a = 1.00000  -1.83322   0.98426

  if (nargin() ~= 2)
    error("Wrong number of input arguments.");
  elseif ( ~isvector(frequencies) | ~isvector(bandwidths) )
      if ( ~isscalar(frequencies) | ~isscalar(bandwidths) )
        error("All arguments must be vectors or scalars.");
      end
  elseif ( length(frequencies) ~= length (bandwidths) )
    error("All arguments must be of equal length.");
  elseif (~and( frequencies > 0 & frequencies < 1 ))
    error("All frequencies must be in (0, 1).");
  elseif (~and( bandwidths > 0 & bandwidths < 1 ))
    error("All bandwidths must be in (0, 1).");
  end

  frequencies = frequencies (:)';
  bandwidths  = bandwidths (:)';

  frequencies = frequencies*%pi;
  bandwidths  = bandwidths*%pi;
  M2 = 2 * length(frequencies);

  a = [ frequencies - bandwidths / 2; frequencies ];
  omega = a(:);
  factors = ( 1 : 2 : M2 );
  b = [ -%pi * factors + %pi / 2; -%pi * factors ];
  phi = b(:);
  t_beta = tan ( ( phi + M2 * omega ) / 2 );

  Q = zeros (M2, M2);

  for k = 1 : M2
    Q ( :, k ) = sin ( k .* omega ) - t_beta .* cos ( k .* omega );
  end

  h_a   = ( Q \ t_beta )';
  denom = [ 1, h_a ];
  num   = [ flipdim(h_a, 2), 1 ];

  a = denom;
  b = ( num + denom ) / 2;

endfunction

//input validation:
//assert_checkerror("pei_tseng_notch()", "Wrong number of input arguments.");
//assert_checkerror("pei_tseng_notch([1, 2, 3])", "Wrong number of input arguments.");
//assert_checkerror("pei_tseng_notch([1, 2; 3, 4], [4; 5; 6])", "All arguments must be vectors or scalars.");
//assert_checkerror("pei_tseng_notch([1, 2, 3, 4], [5, 6])", "All arguments must be of equal length.");
//assert_checkerror("pei_tseng_notch([1, 2, 3], [4, 5, 6])", "All frequencies must be in (0, 1).");
//assert_checkerror("pei_tseng_notch([0.1, 0.2, 0.3], [4, 5, 6])", "All bandwidths must be in (0, 1).");

//tests:
//assert_checkequal(pei_tseng_notch(0.2, 0.4), [0 0 0]);
//assert_checkalmostequal(pei_tseng_notch([0.2, 0.5, 0.9], [0.1, 0.3, 0.5]), [0.41549, 0.11803, -0.03227, 0.23606, -0.03227, 0.11803, 0.41549], 5*10^-4);
//assert_checkequal(pei_tseng_notch([0.2; 0.5; 0.9], [0.1, 0.3, 0.5]), pei_tseng_notch([0.2, 0.5, 0.9], [0.1; 0.3; 0.5]));
//assert_checkalmostequal(pei_tseng_notch([0.2, 0.7], [0.1, 0.3]), [0.60331, -0.26694, 0.05905, -0.26694, 0.60331], 5*10^-4);
