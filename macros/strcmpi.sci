function result = strcmpi(str1, str2)
    //  Internal helper function
    
    lowerStr1 = convstr(str1, "l");
    lowerStr2 = convstr(str2, "l");
    result = strcmp(lowerStr1, lowerStr2);
    result = double(result);
endfunction