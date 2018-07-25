//This function calculates coefficients of an autoregressive (AR) model of complex data

//Calling Sequence
//a = arburg(x, poles)
//a = arburg(x, poles, criterion)
//[a, v] = arburg(...)
//[a, v, k] = arburg(...)

//Parameters
//x: vector of real or complex numbers, of length > 2
//poles: positive integer value < length(x) - 2
//criterion: string value, takes in "AKICc", "KIC", "AICc", "AIC" and "FPE", default it not using a model-selection criterion
//a: list of P+1 autoregression coefficients.
//v:  mean square of residual noise from the whitening operation of the Burg lattice filter
//k: reflection coefficients defining the lattice-filter embodiment of the model

//Description
//This function calculates coefficients of an autoregressive (AR) model of complex data x using the whitening lattice-filter method of Burg.
//The first argument is the data sampled. The second argument is the number of poles in the model (or limit in case a criterion is supplied).
//The third parameter takes in the criterion to limit the number of poles. The acceptable values are "AIC", "AKICc", "KIC", "AICc" which are based on information theory.

//Examples
//arburg([1,2,3,4,5],2)
// ans  =
//
//    1.  - 1.8639053    0.9571006


//*************************************************************************************
//-------------------version1 (using callOctave / errored)-----------------------------
//*************************************************************************************
//function varargout = arburg( x, poles, criterion )
//funcprot(0);
//rhs = argn(2)
//lhs = argn(1)
//if(lhs>3)
//error("Wrong number of output arguments.")
//elseif(rhs<2)
//error("Wrong number of input arguments.")
//end
//
//	select(lhs)
//	case 1 then
//	if(rhs==2)
//	a = callOctave("arburg",x,poles)
//	elseif(rhs==3)
//	a = callOctave("arburg",x,poles,criterion)
//	end
//	case 2 then
//	if(rhs==2)
//	[a,v] = callOctave("arburg",x,poles)
//	elseif(rhs==3)
//	[a,v] = callOctave("arburg",x,poles,criterion)
//	end
//	case 3 then
//	if(rhs==2)
//	[a,v,k] = callOctave("arburg",x,poles)
//	elseif(rhs==3)
//	[a,v,k] = callOctave("arburg",x,poles,criterion)
//	end
//	end
//endfunction
//

//*************************************************************************************
//-----------------------------version2 (pure scilab code)-----------------------------
//*************************************************************************************

function varargout = arburg( x, poles, criterion )

  funcprot(0);
  // Check arguments
  [nargout nargin ] = argn() ;
  if ( nargin < 2 )
    error( 'arburg(x,poles): Need at least 2 args.' );
  elseif ( ~isvector(x) | length(x) < 3 )
    error( 'arburg: arg 1 (x) must be vector of length >2.' );
  elseif ( ~isscalar(poles) | ~isreal(poles) | fix(poles)~=poles | poles<=0.5)
    error( 'arburg: arg 2 (poles) must be positive integer.' );
  elseif ( poles >= length(x)-2 )
    // lattice-filter algorithm requires "poles<length(x)"
    // AKICc and AICc require "length(x)-poles-2">0
    error( 'arburg: arg 2 (poles) must be less than length(x)-2.' );
  elseif ( nargin>2 & ~isempty(criterion) & ...
          (~(type(criterion) == 10 ) | size(criterion,1)~=1 ) )
    error( 'arburg: arg 3 (criterion) must be string.' );
  else
    //
    //  Set the model-selection-criterion flags.
    //  is_AKICc, isa_KIC and is_corrected are short-circuit flags
    if ( nargin > 2 & ~isempty(criterion) )
      is_AKICc = strcmp(criterion,'AKICc');                 // AKICc
      isa_KIC  = is_AKICc | strcmp(criterion,'KIC');       // KIC or AKICc
      is_corrected = is_AKICc | strcmp(criterion,'AICc');  // AKICc or AICc
      use_inf_crit = is_corrected | isa_KIC | strcmp(criterion,'AIC');
      use_FPE = strcmp(criterion,'FPE');
      if ( ~use_inf_crit & ~use_FPE )
        error( 'arburg: value of arg 3 (criterion) not recognized' );
      end
    else
      use_inf_crit = 0;
      use_FPE = 0;
    end
    //
    // f(n) = forward prediction error
    // b(n) = backward prediction error
    // Storage of f(n) and b(n) is a little tricky. Because f(n) is always
    // combined with b(n-1), f(1) and b(N) are never used, and therefore are
    // not stored.  Not storing unused data makes the calculation of the
    // reflection coefficient look much cleaner :)
    // N.B. {initial v} = {error for zero-order model} =
    //      {zero-lag autocorrelation} =  E(x*conj(x)) = x*x'/N
    //      E = expectation operator
    N = length(x);
    k = [];
    if ( size(x,1) > 1 ) // if x is column vector
      f = x(2:N);
      b = x(1:N-1);
      v = real(x'*x) / N;
    else                 // if x is row vector
      f = x(2:N).';
      b = x(1:N-1).';
      v = real(x*x') / N;
    end
    // new_crit/old_crit is the mode-selection criterion
    new_crit = abs(v);
    old_crit = 2 * new_crit;
    for p = 1:poles
      //
      // new reflection coeff = -2* E(f.conj(b)) / ( E(f^2)+E(b(^2) )
      last_k= -2 * (b' * f) / ( f' * f + b' * b);
      //  Levinson-Durbin recursion for residual
      new_v = v * ( 1.0 - real(last_k * conj(last_k)) );
      if ( p > 1 )
        //
        // Apply the model-selection criterion and break out of loop if it
        // increases (rather than decreases).
        // Do it before we update the old model "a" and "v".
        //
        // * Information Criterion (AKICc, KIC, AICc, AIC)
        if ( use_inf_crit )
          old_crit = new_crit;
          // AKICc = log(new_v)+p/N/(N-p)+(3-(p+2)/N)*(p+1)/(N-p-2);
          // KIC   = log(new_v)+           3         *(p+1)/N;
          // AICc  = log(new_v)+           2         *(p+1)/(N-p-2);
          // AIC   = log(new_v)+           2         *(p+1)/N;
          // -- Calculate KIC, AICc & AIC by using is_AKICc, is_KIC and
          //    is_corrected to "short circuit" the AKICc calculation.
          //    The extra 4--12 scalar arithmetic ops should be quicker than
          //    doing if...elseif...elseif...elseif...elseif.
          new_crit = log(new_v) + is_AKICc*p/N/(N-p) + ...
                     (2+isa_KIC-is_AKICc*(p+2)/N) * (p+1) / (N-is_corrected*(p+2));
          if ( new_crit > old_crit )
            break;
          end
        //
        // (FPE) Final prediction error
        elseif ( use_FPE )
          old_crit = new_crit;
          new_crit = new_v * (N+p+1)/(N-p-1);
          if ( new_crit > old_crit )
            break;
          end
        end
        // Update model "a" and "v".
        // Use Levinson-Durbin recursion formula (for complex data).
        a = [ prev_a + last_k .* conj(prev_a(p-1:-1:1))  last_k ];
      else // if( p==1 )
        a = last_k;
      end
      k = [ k; last_k ];
      v = new_v;
      if ( p < poles )
        prev_a = a;
        //  calculate new prediction errors (by recursion):
        //  f(p,n) = f(p-1,n)   + k * b(p-1,n-1)        n=2,3,...n
        //  b(p,n) = b(p-1,n-1) + conj(k) * f(p-1,n)    n=2,3,...n
        //  remember f(p,1) is not stored, so don't calculate it; make f(p,2)
        //  the first element in f.  b(p,n) isn't calculated either.
        nn = N-p;
        new_f = f(2:nn) + last_k * b(2:nn);
        b = b(1:nn-1) + conj(last_k) * f(1:nn-1);
        f = new_f;
      end
    end

    varargout(1) = [1,a];
    varargout(2) = v;
    if ( nargout>=3 )
      varargout(3) = k;
    end
  end

endfunction
