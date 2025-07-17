// Copyright (C) 2017 - IIT Bombay - FOSSEE
//
// Author: Shamika Mohanan
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

mode(-1)
lines(0)

toolbox_title = "FOSSEE_Signal_Processing_Toolbox"

help_dir = get_absolute_file_path('builder_help.sce');

// Uncomment this only when You are making changes to user documentation
// Adding a new function or during devlopment
// For final testing and release keep them Commented 
// I don't know why it couurpts documentation in scilab >=2024.1.0
// So be safe
if (isdir(help_dir + "/en_US/"))then
    xmlfiles = findfiles(help_dir + "/en_US/", "*.xml");
    if ~isempty(xmlfiles) then
       root_tlbx = toolbox_dir;
       exec(help_dir + "cleaner_help.sce");
       clear root_tlbx
    end
    help_from_sci(toolbox_dir+"/macros/",help_dir+"/en_US/");
end

if ~(isdir(toolbox_dir+ "/jar/")) then
    mkdir(toolbox_dir+ "/jar/");
end

tbx_builder_help_lang("en_US", help_dir);

clear toolbox_title;
