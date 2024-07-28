require 'xcodeproj'

module_name = ARGV[0]
project_path = ARGV[1]
module_folder_path = ARGV[2]

project = Xcodeproj::Project.open(project_path)
demos_group = project.main_group["NowaguardVPN"]
flow_group = demos_group["Flow"]

module_group = flow_group.new_group(module_name, module_folder_path)

def add_files_to_group(folder_path, group, project)
    Dir.foreach(folder_path) do |entry|
        next if entry == '.' or entry == '..'
        full_path = File.join(folder_path, entry)
        if File.directory?(full_path)
            sub_group = group.new_group(entry, entry)
            add_files_to_group(full_path, sub_group, project)
        else
            file_reference = group.new_file(full_path)

                project.targets.first.source_build_phase.add_file_reference(file_reference)
            
        end
    end
end

add_files_to_group(module_folder_path, module_group, project)

project.save
