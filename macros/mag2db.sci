
function [ydb] = mag2db(y)
//The relationship between magnitude and decibels is ydb = 20 log10(y).
//ydb = mag2db(y) expresses in decibels (dB) the magnitude measurements specified in y. 
//Author 
//Debdeep Dey

    funcprot(0);

    ydb(find(abs(y)>0))= 20 * log10(y(find(abs(y)>0)));
    ydb(find(real(y)<0))=%nan;
    ydb(find(y==0))=-%inf;
    ydb=matrix(ydb,size(y));
        

endfunction

