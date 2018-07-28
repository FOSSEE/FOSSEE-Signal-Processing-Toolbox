mode(-1);

// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the BSD.
// This source file is licensed as described in the file LICENSE, which
// you should have received as part of this distribution.  The terms
// are also available at
// https://opensource.org/licenses/BSD-3-Clause
// Author: Sunil Shetye
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

lines(0);
try
 getversion('scilab');
catch
 error(gettext('Scilab 5.5.0 or 5.5.2 is required.'));
end;

// ====================================================================
if ~with_module("development_tools") then
  error(msprintf(gettext("%s module not installed."),"development_tools"));
end
// ====================================================================
TOOLBOX_NAME = "FOSSEE_Signal_Processing_Toolbox";
TOOLBOX_TITLE = "FOSSEE Signal Processing Toolbox";
// ====================================================================


toolbox_dir = get_absolute_file_path("builder.sce");
//help_from_sci("macros","help/en_US");
tbx_builder_help(toolbox_dir);
exec help/en_US/addchapter.sce

clear toolbox_dir TOOLBOX_NAME TOOLBOX_TITLE;
