// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
/// Author : Abinash Singh Under FOSSEE Internship
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function [ dSided, minH, minD, minW, maxW ] = parser ( varargin )
    // Default values
    // This is an helper function for findpeaks
    // It parses the input arguments and returns the values of the options
    dSided = %f ; 
    minH = %eps ;
    minD = 1 ;
    minW = %eps;
    maxW = %inf ;
    idx = 1 ;
    while idx <= length(varargin)  
        select lower(varargin(idx)) 
        case 'doublesided' 
            dSided = %t ;
            idx = idx + 1 ;
        case 'minpeakheight' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakHeight must be a postive scalar') ;
            end
            minH = varargin(idx+1) ;
            idx = idx + 2 ;
        case 'minpeakdistance' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakDistance must be a postive scalar') ;
            end
            minD = varargin(idx+1) ;
            idx = idx + 2 ;
        case 'minpeakwidth' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakWidth must be a postive scalar') ;
            end
            minW = varargin(idx+1) ;
            idx = idx + 2 ;    
        case 'maxpeakwidth' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MaxPeakWidth must be a postive scalar') ;
            end
            maxW = varargin(idx+1) ;
            idx = idx + 2 ;    
        else 
            warning("findpeaks: Ignoring unknown option ") ;
            idx = idx + 1 ;
        end
         
    end
endfunction

function y = lower (y)
    // This function converts the input string to lower case
    //  Returns the input without modification if its not a string
    if type(y) == 10 then 
        y = convstr(y, 'l') ;
    else
        y = y ;
    end

endfunction

function out = bsminuseq(A)
    // This function returns the difference between the elements of the input array
    // This is only useful for the findpeaks function
    A = A(:).' ;
    atemp = [];
    btemp=[] ;
    for i=1:length(A) 
        atemp = [atemp ; A ]
        btemp = [btemp  A.' ]
    end
    out = atemp - btemp
endfunction
