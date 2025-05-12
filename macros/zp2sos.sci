function [SOS, G] = zp2sos(z, p, k, DoNotCombineReal)
// This function converts filter poles and zeros to second-order sections.
//
// Syntax
// [sos] = zp2sos(z)
// [sos] = zp2sos(z, p)
// [sos] = zp2sos(z, p, k)
// [sos, g] = zp2sos(...)
//
// Parameters 
// z: column vector
// p: column vector
// k: real or complex value, default value is 1
//
// Description
// This function converts filter poles and zeros to second-order sections.
// The first and second parameters are column vectors containing zeros and poles. The third parameter is the overall filter gain, the default value of which is 1.
// The output is the sos matrix and the overall gain.
// If there is only one output argument, the overall filter gain is applied to the first second-order section in the sos matrix.
//
// Examples
// zp2sos([1, 2, 3], 2, 6)

  if argn(2) < 3 then
    k = 1;
  end
  if argn(2) < 2 then
    p = [];
  end

  DoNotCombineReal = 0;

  [zc, zr] = cplxreal(z(:));
  [pc, pr] = cplxreal(p(:));

  nzc = length(zc);
  npc = length(pc);

  nzr = length(zr);
  npr = length(pr);

  if DoNotCombineReal then

    // Handling complex conjugate poles
    for count = 1:npc
      SOS(count, 4:6) = [1, -2 * real(pc(count)), abs(pc(count))^2];
    end

    // Handling real poles
    for count = 1:npr
      SOS(count + npc, 4:6) = [0, 1, -pr(count)];
    end

    // Handling complex conjugate zeros
    for count = 1:nzc
      SOS(count, 1:3) = [1, -2 * real(zc(count)), abs(zc(count))^2];
    end

    // Handling real zeros
    for count = 1:nzr
      SOS(count + nzc, 1:3) = [0, 1, -zr(count)];
    end

    // Completing SOS if needed (sections without pole or zero)
    if npc + npr > nzc + nzr then
      for count = nzc + nzr + 1 : npc + npr // sections without zero
        SOS(count, 1:3) = [0, 0, 1];
      end
    else
      for count = npc + npr + 1 : nzc + nzr // sections without pole
        SOS(count, 4:6) = [0, 0, 1];
      end
    end

  else

    // Handling complex conjugate poles
    for count = 1:npc
      SOS(count, 4:6) = [1, -2 * real(pc(count)), abs(pc(count))^2];
    end

    // Handling pair of real poles
    for count = 1:floor(npr / 2)
      SOS(count + npc, 4:6) = [1, -pr(2 * count - 1) - pr(2 * count), pr(2 * count - 1) * pr(2 * count)];
    end

    // Handling last real pole (if any)
    if pmodulo(npr, 2) == 1 then
      SOS(npc + floor(npr / 2) + 1, 4:6) = [0, 1, -pr($)];
    end

    // Handling complex conjugate zeros
    for count = 1:nzc
      SOS(count, 1:3) = [1, -2 * real(zc(count)), abs(zc(count))^2];
    end

    // Handling pair of real zeros
    for count = 1:floor(nzr / 2)
      SOS(count + nzc, 1:3) = [1, -zr(2 * count - 1) - zr(2 * count), zr(2 * count - 1) * zr(2 * count)];
    end

    // Handling last real zero (if any)
    if pmodulo(nzr, 2) == 1 then
      SOS(nzc + floor(nzr / 2) + 1, 1:3) = [0, 1, -zr($)];
    end

    // Completing SOS if needed (sections without pole or zero)
    if npc + ceil(npr / 2) > nzc + ceil(nzr / 2) then
      for count = nzc + ceil(nzr / 2) + 1 : npc + ceil(npr / 2) // sections without zero
        SOS(count, 1:3) = [0, 0, 1];
      end
    else
      for count = npc + ceil(npr / 2) + 1 : nzc + ceil(nzr / 2) // sections without pole
        SOS(count, 4:6) = [0, 0, 1];
      end
    end
  end

  if ~exists('SOS') then
    SOS = [0, 0, 1, 0, 0, 1]; // leading zeros will be removed
  end

  // Removing leading zeros if present in numerator and denominator
  for count = 1:size(SOS, 1)
    B = SOS(count, 1:3);
    A = SOS(count, 4:6);
    while B(1) == 0 & A(1) == 0 do
      A(1) = [];
      A($ + 1) = 0;
      B(1) = [];
      B($ + 1) = 0;
    end
    SOS(count, :) = [B, A];
  end

  // If no output argument for the overall gain, combine it into the first section.
  if argn(1) < 2 then
    SOS(1, 1:3) = k * SOS(1, 1:3);
  else
    G = k;
  end
endfunction

//tests
//sos = zp2sos ([]);
//sos = zp2sos ([], []);
//sos = zp2sos ([], [], 2);
//[sos, g] = zp2sos ([], [], 2);
//sos = zp2sos([], [0], 1);
//sos = zp2sos([0], [], 1);
//sos = zp2sos([1,2,3,4,5,6], 2);
//sos = zp2sos([-1-%i, -1+%i], [-1-2*%i, -1+2*%i], 10);
