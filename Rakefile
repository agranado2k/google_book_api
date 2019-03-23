# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require "rubocop/rake_task"
require 'rspec/core/rake_task'

Rails.application.load_tasks
Rake::Task["default"].clear

namespace 'app_test' do
  task :brakeman do
    sh "bundle exec brakeman -A"
  end

  task :bundle_audit do
    sh 'bundle exec bundle audit'
  end

  task :all do
    RSpec::Core::RakeTask.new(:rspec)
    RuboCop::RakeTask.new(:rubocop)
    Rake::Task['rspec'].invoke
    Rake::Task['app_test:brakeman'].invoke
    Rake::Task['rubocop'].invoke
    Rake::Task['app_test:bundle_audit'].invoke
  end
end

task :default => ['app_test:all']

