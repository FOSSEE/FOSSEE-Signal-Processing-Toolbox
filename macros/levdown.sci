function [a,e]=levdown(a, efinal)
// Reduce the order of an autoregressive (AR) model using Levinson-Durbin recursion.
//
// Syntax
//   [a, e] = levdown(a, efinal)
//
// Parameters
// a: Vector of AR coefficients of the current model.
// efinal: Final prediction error of the current model.
//
// Outputs
// a: Vector of AR coefficients of the reduced-order model.
// e: Prediction error of the reduced-order model.
//
// Description
// The `levdown` function reduces the order of an autoregressive (AR) model by one using a step in the Levinson-Durbin recursion. 
// It computes the AR coefficients and prediction error for the reduced-order model based on the AR coefficients and prediction error of the current model.
//
// The function performs the following steps:
// 1. Extracts the last coefficient of the AR model.
// 2. Updates the AR coefficients using the Levinson-Durbin recursion formula.
// 3. Removes the last coefficient to reduce the order of the AR model.
// 4. Updates the prediction error for the reduced-order model.
//
// Examples
// // Reduce the order of an AR model:
//    a = [1, -0.5, 0.25]
//    efinal = 0.1
//    [a_reduced, e_reduced] = levdown(a, efinal)
//
// Authors
// FOSSEE Team
// toolbox@scilab.in
    
                   ee=a($);
                 
                  a = (a-a($)*flipdim(a,2,1))/(1-a($)^2);
                                               
                      a=a(1:$-1)
                  
         
      econj=conj(ee);
    econj=econj';
    e = efinal/(1.-(econj.*ee));      
                              
endfunction
