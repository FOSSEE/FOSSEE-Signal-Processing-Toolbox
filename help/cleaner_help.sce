help_dir = get_absolute_file_path('cleaner_help.sce');

// Cleaning en_US directory
if isdir(help_dir + "/en_US") then
    xmlfiles = findfiles(help_dir + "/en_US/", "*.xml");
    if ~isempty(xmlfiles) then
        deletefile(help_dir+ "/en_US/" + xmlfiles);
    end
    rmdir(help_dir + "/en_US/scilab_en_US_help", "s");
end

// Cleaning the jar files
if isdir(root_tlbx + "/jar/") then
   rmdir(root_tlbx + "/jar","s");
end

clear help_dir xmlfiles ;