# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "Prints the age of the current app by calculating how old the rake file is in git"
task :age do
  days = (DateTime.now - DateTime.parse(`git log --format=%aD #{__FILE__} | tail -1`.chomp)).to_i
  puts "App is #{days} days old"
end

