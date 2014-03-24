gettext_find_task = Rake::Task['gettext:find'] rescue nil

if gettext_find_task
  namespace :gettext do
    task :store_action_names => :environment do
      storage_file = "#{locale_path}/action_names.rb"
      puts "writing action translations to: #{storage_file}"

      File.write storage_file,
                 "# Autogenerated!\n" +
                     Actions::EntryAction.
                         all_action_names.
                         uniq.
                         map { |n| %[_("#{n}")] }.
                         join("\n")
    end
  end

  gettext_find_task.enhance ['gettext:store_action_names']
end

