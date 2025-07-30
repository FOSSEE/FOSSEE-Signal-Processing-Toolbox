function varargout = pwelch(x,varargin)
// Estimate power spectral density of data "x" by the Welch (1967) periodogram/FFT method.
//
// Syntax
//   [spectra, freq] = pwelch(x, y, window, overlap, Nfft, Fs, range, plot_type, detrend, sloppy, results)
//   [spectra, Pxx_ci, freq] = pwelch(x, window, overlap, Nfft, Fs, conf, range, plot_type, detrend, sloppy)
//   [spectra, Pxx_ci, freq] = pwelch(x, y, window, overlap, Nfft, Fs, conf, range, plot_type, detrend, sloppy, results)
//
// Parameters
// x: [non-empty vector] System-input time-series data.
// y: [non-empty vector] System-output time-series data.
// window: [real vector] Window-function values between 0 and 1. Default is Hamming.
//         [integer scalar] Length of each data segment. Default is sqrt(length(x)) rounded up to the nearest integer power of 2.
// overlap: [real scalar] Segment overlap expressed as a multiple of window or segment length. Default is 0.5.
// Nfft: [integer scalar] Length of FFT. Default is the length of the "window" vector or the scalar "window" argument.
// Fs: [real scalar] Sampling frequency (Hertz). Default is 1.0.
// conf: [real scalar] Confidence level between 0 and 1. Default is 0.95.
// range: Frequency range of the spectrum. Options are 'half', 'onesided', 'whole', 'twosided', 'shift', 'centerdc'.
// plot_type: Specifies the type of plot. Options are 'plot', 'semilogx', 'semilogy', 'loglog', 'squared', 'db'. Default is 'plot'.
// detrend: Specifies how to remove trends from the data. Options are 'no-strip', 'none', 'short', 'mean', 'linear', 'long-mean'. Default is 'long-mean'.
// sloppy: Adjusts FFT length to the nearest integer power of 2 by zero padding. Default is exact FFT length.
// results: Specifies what results to return. Options are 'power', 'cross', 'trans', 'coher', 'ypower'. Default is 'power'.
//
// Description
// The `pwelch` function estimates the power spectral density (PSD) of data "x" using the Welch periodogram/FFT method. 
// It supports single-channel and two-channel spectrum analysis, including power spectral density, cross-spectral density, 
// transfer function, and coherence functions.
//
// The data is divided into overlapping segments. Each segment is windowed using the specified window function (e.g., Hamming) 
// and zero-padded to the desired FFT length. The periodogram is computed for each segment, and the PSD is obtained by averaging 
// the periodograms. This averaging reduces the variance of the spectral estimate.
//
// The function also supports confidence interval estimation for the PSD, which is based on the scatter in the periodograms. 
// However, confidence intervals are only available for the power spectrum of "x" and not for cross-power spectra, transfer functions, 
// or coherence functions.
//
// The `pwelch` function provides compatibility with different versions of MATLAB (R11, R12, R14) and their respective default behaviors. 
// It also includes options for customizing the frequency range, plot type, and detrending method.
//
// Notes
// - The spectral density is scaled so that the area under the spectrum equals the mean square of the data.
// - The function supports both one-sided and two-sided spectra. For one-sided spectra, contributions from negative frequencies 
//   are added to the positive side of the spectrum.
// - The default window function is Hamming, but other window functions (e.g., Hann, Bartlett) can be used.
// - Zero-padding increases the frequency resolution but does not improve the accuracy of the spectral estimate.
// - The function can handle real and complex data. For real data, the default frequency range is 'half'; for complex data, it is 'whole'.
//
// Examples
// // Compute power spectral density of a signal:
//    x = rand(1, 1024);
//    [spectra, freq] = pwelch(x)
//

    nargin = argn(2)
    compat_str = {[]; 'R11-'; 'R12+'; 'psd'};
    global compatib
    if ( isempty(compatib) || compatib<=0 || compatib>4 )
      // legal values are 1, 2, 3, 4
      compatib = 1;
    end
    if ( nargin <= 0 )
      error(sprintf( 'pwelch: Need at least 1 arg. Use help pwelch.' ));
    elseif ( nargin==1 && (type(x) == 10 ) || isempty(x)) 
      varargout(1) = compat_str{compatib};
      if ( isempty(x) ) // native
        compatib = 1;
      elseif ( ~strcmp(x,'R11-') )
        compatib = 2;
      elseif ( ~strcmp(x,'R12+') )
        compatib = 3;
      elseif ( ~strcmp(x,'psd') )
        compatib = 4;
      else
        error(sprintf( 'pwelch: compatibility arg must be empty, R11-, R12+ or psd' ));
      end
      // return
    //
    // Check fixed argument
    elseif ( isempty(x) || ~isvector(x) )
      error(sprintf( 'pwelch: arg 1 (x) must be vector.' ));
    else
      //  force x to be COLUMN vector
      if ( size(x,1)==1 )
        x=x(:);
      end
      //
      // Look through all args to check if  cross PSD, transfer function or
      // coherence is required.  If yes, the second arg is data vector "y".
      arg2_is_y = 0;
      x_len = max(size(x));
      nvarargin = max(size(varargin));
      for iarg=1:nvarargin
        arg = varargin(iarg);
        if ( ~isempty(arg) && (type(arg) == 10 ) && ...
             ( ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
               ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
          // OK. Need "y". Grab it from 2nd arg.
          arg = varargin(1);
          if ( nargin<2 || isempty(arg) || ~isvector(arg) || max(size(arg))~=x_len )
            error(sprintf( 'pwelch: arg 2 (y) must be vector, same length as x.' ));
          end
          // force  COLUMN vector
          y = varargin(1)(:);
          arg2_is_y = 1;
          break;
        end
      end
      //
      // COMPATIBILITY
      // To select default argument values, "compatib" is used as an array index.
      // Index values are   1=native,  2=R11,  3=R12,  4=spectrum.welch
      //
      //  argument positions:
      //  arg_posn = varargin index of window, overlap, Nfft, Fs and conf
      //             args respectively, a value of zero ==>> arg does not exist
      arg_posn = [1 2 3 4 5;  // native
                  3 4 1 2 5;  // Matlab R11- pwelch
                  1 2 3 4 0;  // Matlab R12+ pwelch
                  1 2 3 4 5]; // spectrum.welch defaults
      arg_posn  = arg_posn(compatib,:) + arg2_is_y;
      //
      //  SPECIFY SOME DEFAULT VALUES for (not all) optional arguments
      //  Use compatib as array index.
      //  Fs = sampling frequency
      Fs        = [ 1.0 2*%pi 2*%pi 2*%pi ];
      Fs        = Fs(compatib);
      //  plot_type: 1='plot'|'squared'; 5='db'|'dB'
      plot_type = [ 1 5 5 5 ];
      plot_type = plot_type(compatib);
      //  rm_mean: 3='long-mean'; 0='no-strip'|'none'
      rm_mean   = [ 3 0 0 0 ];
      rm_mean   = rm_mean(compatib);
      // use max_overlap=x_len-1 because seg_len is not available yet
      // units of overlap are different for each version:
      //    fraction, samples, or percent
      max_overlap = [ 0.95 x_len-1 x_len-1 95];
      max_overlap = max_overlap(compatib);
      // default confidence interval
      //  if there are more than 2 return values and if there is a "conf" arg
      conf      = 0.95 * (nargout>2) * (arg_posn(5)>0);
      //
      is_win    = 0;    // =0 means valid window arg is not provided yet
      Nfft      = [];   // default depends on segment length
      overlap   = [];   // WARNING: units can be //samples, fraction or percentage
      range     = ~isreal(x) || ( arg2_is_y && ~isreal(y) );
      is_sloppy = 0;
      n_results = 0;
      do_power  = 0;
      do_cross  = 0;
      do_trans  = 0;
      do_coher  = 0;
      do_ypower = 0;
    //
    //  DECODE AND CHECK OPTIONAL ARGUMENTS
      end_numeric_args = 0;
      for iarg = 1+arg2_is_y:nvarargin
        arg = varargin(iarg);
        if ( ( type (arg) == 10 ) )
          // first string arg ==> no more numeric args
          // non-string args cannot follow a string arg
          end_numeric_args = 1;
          //
          // decode control-string arguments
          if ( ~strcmp(arg,'sloppy') )
            is_sloppy = ~is_win || is_win==1;
          elseif ( ~strcmp(arg,'plot') || ~strcmp(arg,'squared') )
            plot_type = 1;
          elseif ( ~strcmp(arg,'semilogx') )
            plot_type = 2;
          elseif ( ~strcmp(arg,'semilogy') )
            plot_type = 3;
          elseif ( ~strcmp(arg,'loglog') )
            plot_type = 4;
          elseif ( ~strcmp(arg,'db') || ~strcmp(arg,'dB') )
            plot_type = 5;
          elseif ( ~strcmp(arg,'half') || ~strcmp(arg,'onesided') )
            range = 0;
          elseif ( ~strcmp(arg,'whole') || ~strcmp(arg,'twosided') )
            range = 1;
          elseif ( ~strcmp(arg,'shift') || ~strcmp(arg,'centerdc') )
            range = 2;
          elseif ( ~strcmp(arg,'long-mean') )
            rm_mean = 3;
          elseif ( ~strcmp(arg,'linear') )
            rm_mean = 2;
          elseif ( ~strcmp(arg,'short') || ~strcmp(arg,'mean') )
            rm_mean = 1;
          elseif ( ~strcmp(arg,'no-strip') || ~strcmp(arg,'none') )
            rm_mean = 0;
          elseif ( ~strcmp(arg, 'power' ) )
            if ( ~do_power )
              n_results = n_results+1;
              do_power = n_results;
            end
          elseif ( ~strcmp(arg, 'cross' ) )
            if ( ~do_cross )
              n_results = n_results+1;
              do_cross = n_results;
            end
          elseif ( ~strcmp(arg, 'trans' ) )
            if ( ~do_trans )
              n_results = n_results+1;
              do_trans = n_results;
            end
          elseif ( ~strcmp(arg, 'coher' ) )
            if ( ~do_coher )
              n_results = n_results+1;
              do_coher = n_results;
            end
          elseif ( ~strcmp(arg, 'ypower' ) )
            if ( ~do_ypower )
              n_results = n_results+1;
              do_ypower = n_results;
            end
          else
            error(sprintf( 'pwelch: string arg %d illegal value: %s', iarg+1, arg ));
          end
          // end of processing string args
          //
        elseif ( end_numeric_args )
          if ( ~isempty(arg) )
            // found non-string arg after a string arg ... oops
            error(sprintf( 'pwelch: control arg must be string' ));
          end
        //
        // first 4 optional arguments are numeric -- in fixed order
        //
        // deal with "Fs" and "conf" first because empty arg is a special default
        // -- "Fs" arg -- sampling frequency
        elseif ( iarg == arg_posn(4) )
          if ( isempty(arg) )
            Fs = 1;
          elseif ( ~isscalar(arg) || ~isreal(arg) || arg<0 )
            error(sprintf( 'pwelch: arg %d (Fs) must be real scalar >0', iarg+1 ));
          else
            Fs = arg;
          end
        //
        //  -- "conf" arg -- confidence level
        //    guard against the "it cannot happen" iarg==0
        elseif ( arg_posn(5) && iarg == arg_posn(5) )
          if ( isempty(arg) )
            conf = 0.95;
          elseif ( ~isscalar(arg) || ~isreal(arg) || arg < 0.0 || arg >= 1.0 )
            error(sprintf( 'pwelch: arg %d (conf) must be real scalar, >=0, <1',iarg+1 ));
          else
            conf = arg;
          end
        //
        // skip all empty args from this point onward
        elseif ( isempty(arg) )
          1;
        //
        //  -- "window" arg -- window function
        elseif ( iarg == arg_posn(1) )
          if ( isscalar(arg) )
            is_win = 1;
          elseif ( isvector(arg) )
            is_win = max(size(arg));
            if ( size(arg,2)>1 )  // vector must be COLUMN vector
              arg = arg(:);
            end
          else
            is_win = 0;
          end
          if ( ~is_win )
            error(sprintf( 'pwelch: arg %d (window) must be scalar or vector', iarg+1 ));
          elseif ( is_win==1 && ( ~isreal(arg) || fix(arg)~=arg || arg<=3 ) )
            error(sprintf( 'pwelch: arg %d (window) must be integer >3', iarg+1 ));
          elseif ( is_win>1 && ( ~isreal(arg) ) )
            error(sprintf( 'pwelch: arg %d (window) vector must be real and >=0',iarg+1));
          end
          window = arg;
          is_sloppy = 0;
        //
        // -- "overlap" arg -- segment overlap
        elseif ( iarg == arg_posn(2) )
          if (~isscalar(arg) || ~isreal(arg) || arg<0 || arg>max_overlap )
            error(sprintf( "pwelch: arg %d (overlap) must be real from 0 to %f",iarg+1, max_overlap ));
          end
          overlap = arg;
        //
        // -- "Nfft" arg -- FFT length
        elseif ( iarg == arg_posn(3) )
          if ( ~isscalar(arg) || ~isreal(arg) || fix(arg)~=arg || arg<0 )
            error(sprintf( 'pwelch: arg %d (Nfft) must be integer >=0', iarg+1 ));
          end
          Nfft = arg;
        //
        else
          error(sprintf( 'pwelch: arg %d  must be string', iarg+1 ));
        end
      end
      if ( conf>0 && (n_results && ~do_power ) )
        error(sprintf('pwelch: can give confidence interval for x power spectrum only' ));
      end
      //
      // end DECODE AND CHECK OPTIONAL ARGUMENTS.
      //
      // SETUP REMAINING PARAMETERS
      // default action is to calculate power spectrum only
      if ( ~n_results )
        n_results = 1;
        do_power = 1;
      end
      need_Pxx = do_power || do_trans || do_coher;
      need_Pxy = do_cross || do_trans || do_coher;
      need_Pyy = do_coher || do_ypower;
      log_two = log(2);
      nearly_one = 0.99999999999;
      //
      // compatibility-options
      // provides exact compatibility with Matlab R11 or R12
      //
      // Matlab R11 compatibility
      if ( compatib==2 )
        if ( isempty(Nfft) )
          Nfft = min( 256, x_len );
        end
        if ( is_win > 1 )
          seg_len = min( max(size(window)), Nfft );
          window = window(1:seg_len);
        else
          if ( is_win )
            // window arg is scalar
            seg_len = window;
          else
            seg_len = Nfft;
          end
          // make Hann window (don't depend on sigproc)
          xx = seg_len - 1;
          window = 0.5 - 0.5 * cos( (2*%pi/xx)*[0:xx].' );
        end
      //
      // Matlab R12 compatibility
      elseif ( compatib==3 )
        if ( is_win > 1 )
          // window arg provides window function
          seg_len = max(size(window));
        else
          // window arg does not provide window function; use Hamming
          if ( is_win )
            // window arg is scalar
            seg_len = window;
          else
            // window arg not available; use R12 default, 8 windows
            // ignore overlap arg; use overlap=50% -- only choice that makes sense
            // this is the magic formula for 8 segments with 50% overlap
            seg_len = fix( (x_len-3)*2/9 );
          end
          // make Hamming window (don't depend on sigproc)
          xx = seg_len - 1;
          window = 0.54 - 0.46 * cos( (2*%pi/xx)*[0:xx].' );
        end
        if ( isempty(Nfft) )
          Nfft = max( 256, 2^ceil(log(seg_len)*nearly_one/log_two) );
        end
      // Matlab R14 psd(spectrum.welch) defaults
      elseif ( compatib==4 )
        if ( is_win > 1 )
          // window arg provides window function
          seg_len = max(size(window));
        else
          // window arg does not provide window function; use Hamming
          if ( is_win )
            // window arg is scalar
            seg_len = window;
          else
            // window arg not available; use default seg_len = 64
            seg_len = 64;
          end
          // make Hamming window (don't depend on sigproc)
          xx = seg_len - 1;
          window = 0.54 - 0.46 * cos( (2*%pi/xx)*[0:xx].' );
        end
        // Now we know segment length,
        // so we can set default overlap as number of samples
        if ( ~isempty(overlap) )
          overlap = fix(seg_len * overlap / 100 );
        end
        if ( isempty(Nfft) )
          Nfft = max( 256, 2^ceil(log(seg_len)*nearly_one/log_two) );
        end
      //
      // default compatibility level
      else // if ( compatib==1 )
        // calculate/adjust segment lenght, window function
        if ( is_win > 1 )
          // window arg provides window function
          seg_len = max(size(window));
        else
          // window arg does not provide window function; use Hamming
          if ( is_win )       // window arg is scalar
            seg_len = window;
          else
            // window arg not available; use default length:
            // = sqrt(max(size(x))) rounded up to nearest integer power of 2
            if ( isempty(overlap) )
              overlap=0.5;
            end
            seg_len = 2 ^ ceil( log(sqrt(x_len/(1-overlap)))*nearly_one/log_two );
          end
          // make Hamming window (don't depend on sigproc)
          xx = seg_len - 1;
          window = 0.54 - 0.46 * cos( (2*%pi/xx)*[0:xx].' );
        end
        // Now we know segment length,
        // so we can set default overlap as number of samples
        if ( ~isempty(overlap) )
          overlap = fix(seg_len * overlap);
        end
        //
        // calculate FFT length
        if ( isempty(Nfft) )
          Nfft = seg_len;
        end
        if ( is_sloppy )
          Nfft = 2 ^ ceil( log(Nfft) * nearly_one / log_two );
        end
      end
      // end of compatibility options
      //
      // minimum FFT length is seg_len
      Nfft = max( Nfft, seg_len );
      // Mean square of window is required for normalizing PSD amplitude.
      win_meansq = (window.' * window) / seg_len;
      //
      // Set default or check overlap.
      if ( isempty(overlap) )
        overlap = fix(seg_len /2);
      elseif ( overlap >= seg_len )
        error(sprintf( 'pwelch: arg (overlap=%d) too big. Must be <max(size(window))=%d',...
               overlap, seg_len ));
      end
      //
      // Pad data with zeros if shorter than segment. This should not happen.
      if ( x_len < seg_len )
        x = [x; zeros(seg_len-x_len,1)];
        if ( arg2_is_y )
          y = [y; zeros(seg_len-x_len,1)];
        end
        x_len = seg_len;
      end
      // end SETUP REMAINING PARAMETERS
      //
      //
      // MAIN CALCULATIONS
      // Remove mean from the data
      if ( rm_mean == 3 )
        n_ffts = max( 0, fix( (x_len-seg_len)/(seg_len-overlap) ) ) + 1;
        x_len  = min( x_len, (seg_len-overlap)*(n_ffts-1)+seg_len );
        if ( need_Pxx || need_Pxy )
          x = x - sum( x(1:x_len) ) / x_len;
        end
        if ( arg2_is_y || need_Pxy)
          y = y - sum( y(1:x_len) ) / x_len;
        end
      end
      //
      // Calculate and accumulate periodograms
      //   xx and yy are padded data segments
      //   Pxx, Pyy, Pyy are periodogram sums, Vxx is for confidence interval
      xx = zeros(Nfft,1);
      yy = xx;
      Pxx = xx;
      Pxy = xx;
      Pyy = xx;
      if ( conf>0 )
        Vxx = xx;
      else
        Vxx = [];
      end
      n_ffts = 0;
      for start_seg = [1:seg_len-overlap:x_len-seg_len+1]
        end_seg = start_seg+seg_len-1;
        // Don't truncate/remove the zero padding in xx and yy
        if ( need_Pxx || need_Pxy )
          if ( rm_mean==1 ) // remove mean from segment
            xx(1:seg_len) = window .* ( ...
              x(start_seg:end_seg) - sum(x(start_seg:end_seg)) / seg_len);
          elseif ( rm_mean == 2 ) // remove linear trend from segment
            xx(1:seg_len) = window .* detrend( x(start_seg:end_seg) );
          else // rm_mean==0 or 3
            xx(1:seg_len) = window .* x(start_seg:end_seg);
          end
          fft_x = fft1(xx);
        end
        if ( need_Pxy || need_Pyy )
          if ( rm_mean==1 ) // remove mean from segment
            yy(1:seg_len) = window .* ( ...
              y(start_seg:end_seg) - sum(y(start_seg:end_seg)) / seg_len);
          elseif ( rm_mean == 2 ) // remove linear trend from segment
            yy(1:seg_len) = window .* detrend( y(start_seg:end_seg) );
          else // rm_mean==0 or 3
            yy(1:seg_len) = window .* y(start_seg:end_seg);
          end
          fft_y = fft1(yy);
        end
        if ( need_Pxx )
          // force Pxx to be real; pgram = periodogram
          pgram = real(fft_x .* conj(fft_x));
          Pxx = Pxx + pgram;
          // sum of squared periodograms is required for confidence interval
          if ( conf>0 )
            Vxx = Vxx + pgram .^2;
          end
        end
        if ( need_Pxy )
          // Pxy (cross power spectrum) is complex. Do not force to be real.
          Pxy = Pxy + fft_y .* conj(fft_x);
        end
        if ( need_Pyy )
          // force Pyy to be real
          Pyy = Pyy + real(fft_y .* conj(fft_y));
        end
        n_ffts = n_ffts +1;
      end
      //
      // Calculate confidence interval
      //    -- incorrectly assumes that the periodogram has Gaussian probability
      //       distribution (actually, it has a single-sided (e.g. exponential)
      //       distribution.
      // Sample variance of periodograms is (Vxx-Pxx.^2/n_ffts)/(n_ffts-1).
      //    This method of calculating variance is more susceptible to round-off
      //  error, but is quicker, and for double-precision arithmetic and the
      //  inherently noisy periodogram (variance==mean^2), it should be OK.
      if ( conf>0 && need_Pxx )
        if ( n_ffts<2 )
          Vxx = zeros(Nfft,1);
        else
          // Should use student distribution here (for unknown variance), but tinv
          // is not a core Matlab function (is in statistics toolbox. Grrr)
          Vxx = (erfinv(conf)*sqrt(2*n_ffts/(n_ffts-1))) * sqrt(Vxx-Pxx.^2/n_ffts);
        end
      end
      //
      // Convert two-sided spectra to one-sided spectra (if range == 0).
      // For one-sided spectra, contributions from negative frequencies are added
      // to the positive side of the spectrum -- but not at zero or Nyquist
      // (half sampling) frequencies.  This keeps power equal in time and spectral
      // domains, as required by Parseval theorem.
      //
      if (  ~ range  )
        if (modulo(Nfft,2) == 0 )    // one-sided, Nfft is even
          psd_len = Nfft/2+1;
          if ( need_Pxx )
            Pxx = Pxx(1:psd_len) + [0; Pxx(Nfft:-1:psd_len+1); 0];
            if ( conf>0 )
              Vxx = Vxx(1:psd_len) + [0; Vxx(Nfft:-1:psd_len+1); 0];
            end
          end
          if ( need_Pxy )
            Pxy = Pxy(1:psd_len) + conj([0; Pxy(Nfft:-1:psd_len+1); 0]);
          end
          if ( need_Pyy )
            Pyy = Pyy(1:psd_len) + [0; Pyy(Nfft:-1:psd_len+1); 0];
          end
        else                    // one-sided, Nfft is odd
          psd_len = (Nfft+1)/2;
          if ( need_Pxx )
            Pxx = Pxx(1:psd_len) + [0; Pxx(Nfft:-1:psd_len+1)];
            if ( conf>0 )
              Vxx = Vxx(1:psd_len) + [0; Vxx(Nfft:-1:psd_len+1)];
            end
          end
          if ( need_Pxy )
            Pxy = Pxy(1:psd_len) + conj([0; Pxy(Nfft:-1:psd_len+1)]);
          end
          if ( need_Pyy )
            Pyy = Pyy(1:psd_len) + [0; Pyy(Nfft:-1:psd_len+1)];
          end
        end
      else                      // two-sided (and shifted)
        psd_len = Nfft;
      end
      // end MAIN CALCULATIONS
      //
      // SCALING AND OUTPUT
      // Put all results in matrix, one row per spectrum
      //   Pxx, Pxy, Pyy are sums of periodograms, so "n_ffts"
      //   in the scale factor converts them into averages
      spectra    = zeros(psd_len,n_results);
      spect_type = zeros(n_results,1);
      scale = n_ffts * seg_len * Fs * win_meansq;
      if ( do_power )
        spectra(:,do_power) = Pxx / scale;
        spect_type(do_power) = 1;
        if ( conf>0 )
          Vxx = [Pxx-Vxx Pxx+Vxx]/scale;
        end
      end
      if ( do_cross )
        spectra(:,do_cross) = Pxy / scale;
        spect_type(do_cross) = 2;
      end
      if ( do_trans )
        spectra(:,do_trans) = Pxy ./ Pxx;
        spect_type(do_trans) = 3;
      end
      if ( do_coher )
        // force coherence to be real
        spectra(:,do_coher) = real(Pxy .* conj(Pxy)) ./ Pxx ./ Pyy;
        spect_type(do_coher) = 4;
      end
      if ( do_ypower )
        spectra(:,do_ypower) = Pyy / scale;
        spect_type(do_ypower) = 5;
      end
      freq = [0:psd_len-1].' * ( Fs / Nfft );
      //
      // range='shift': Shift zero-frequency to the middle
      if ( range == 2 )
        len2 = fix((Nfft+1)/2);
        spectra = [ spectra(len2+1:Nfft,:); spectra(1:len2,:)];
        freq    = [ freq(len2+1:Nfft)-Fs; freq(1:len2)];
        if ( conf>0 )
          Vxx = [ Vxx(len2+1:Nfft,:); Vxx(1:len2,:)];
        end
      end
      //
      //  RETURN RESULTS or PLOT
      // droping non postive values for plots
      function res= postives(x)
            j = 1 ;res = [];
            for i=1:size(x,2)
                if or( x(:,i) < 0 )
                    j = j - 1
                    warning("warning: axis: omitting non-positive data in log plot")
                else
                    res(:,j) = x (:,i)
                end
                j = j + 1
            end
      endfunction
      // --------------------
      if ( nargout>=2 && conf>0 )
        varargout(2) = Vxx;
      end
      if ( nargout>=(2+(conf>0)) )
        // frequency is 2nd or 3rd return value,
        // depends on if 2nd is confidence interval
        varargout(2+(conf>0)) = freq;
      end
      if ( nargout>=1 )
        varargout(1) = spectra;
      end
        //
        // Plot the spectra if there are no return variables.---- nargout can't be zero so lets plot it every time
        plot_title=['power spectrum x ';
                    'cross spectrum   ';
                    'transfer function';
                    'coherence        ';
                    'power spectrum y ' ];
        for ii = 1: n_results
          if ( conf>0 && spect_type(ii)==1 )
            Vxxxx = Vxx;
          else
            Vxxxx = [];
          end
          if ( n_results > 1 )
            figure();
          end
          if ( plot_type == 1 )
            plot(freq,[abs(spectra(:,ii)) Vxxxx]);
          elseif ( plot_type == 2 )
            semilogx(freq,[abs(spectra(:,ii)) Vxxxx]);
          elseif ( plot_type == 3 )
            semilogy(freq,[abs(spectra(:,ii)) postives(Vxxxx)]);
          elseif ( plot_type == 4 )
            loglog(freq,[abs(spectra(:,ii)) Vxxxx]);
          elseif ( plot_type == 5 )  // db
            ylabel( 'amplitude (dB)' );
            plot(freq,[10*log10(abs(spectra(:,ii))) 10*log10(abs(Vxxxx))]);
          end
          title( char(plot_title(spect_type(ii),:)) );
          ylabel( 'amplitude' );
          // Plot phase of cross spectrum and transfer function
          if ( spect_type(ii)==2 || spect_type(ii)==3 )
            figure();
            if ( plot_type==2 || plot_type==4 )
              semilogx(freq,180/%pi*angle(spectra(:,ii)));
            else
              plot(freq,180/%pi*angle(spectra(:,ii)));
            end
            title( char(plot_title(spect_type(ii),:)) );
            ylabel( 'phase' );
          end
        end
      end
    
  endfunction 
  /*
  
// demo 1  // use "hold on" and "hold off" for octave...
   pi = %pi ; i = %i;
   Fs = 25;
   a = [ 1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746 ];
   white = rand(1,16384);
   signal = detrend(filter(0.70181,a,white));
   skewed = signal.*exp(2*pi*i*2/25*[1:16384]);
   compat = pwelch ([]);
   hold on;
   pwelch(skewed,[],[],[],Fs,'shift','semilogy');
   pwelch(skewed,[],[],[],Fs,0.95,'shift','semilogy');
   pwelch('R12+');
   pwelch(signal,'squared');
   pwelch (compat);
   hold off;
// demo 2 // use "hold on" and "hold off" for octave...
 a = [ 1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746 ];
 white = rand(1,16384);
 signal = detrend(filter(0.70181,a,white));
 skewed = signal.*exp(2*pi*i*2/25*[1:16384]);
 compat = pwelch ([]);
 hold on;
 pwelch(signal);
 pwelch(skewed);
 pwelch(signal,'shift','semilogy');
 pwelch (compat);
 hold off
// demo 3 
 a = [ 1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746 ];
 white = rand(1,16384);
 signal = detrend(filter(0.70181,a,white));
 compat = pwelch ([]);
 pwelch(signal,3640,[],4096,2*pi,[],'no-strip');
 pwelch (compat);  
// demo 4 // use "hold on" and "hold off" for octave...
 a = [ 1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746 ];
 white = rand(1,16384);
 signal = detrend(filter(0.70181,a,white));
 compat = pwelch ([]);
 hold on;
 pwelch(signal,[],[],[],2*pi,0.95,'no-strip');
 pwelch(signal,64,[],[],2*pi,'no-strip');
 pwelch(signal,64,[],256,2*pi,'no-strip');
 pwelch (compat);
 hold off;
 //demo 5
 a = [ 1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746 ];
 white = rand(1,16384);
 signal = detrend(filter(0.70181,a,white));
 compat = pwelch ('psd');
 pwelch(signal,'squared');
 pwelch({});
 pwelch(white,signal,'trans','coher','short')
 pwelch (compat);
 */
