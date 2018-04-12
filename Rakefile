#!/usr/bin/env rake
# frozen_string_literal: true

require 'foodcritic'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'
require 'kitchen/rake_tasks'
require 'knife_cookbook_doc/rake_task'
require 'stove/rake_task'

ENV['BERKSHELF_PATH'] = __dir__ + '/.berkshelf'
ENV['CI_REPORTS'] = __dir__ + '/reports'

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    progress: true,
    fail_tags: %w[any]
  }
end

RuboCop::RakeTask.new { |t| t.fail_on_error = true }

RSpec::Core::RakeTask.new(:spec => ['ci:setup:rspec'])

Kitchen::RakeTasks.new

KnifeCookbookDoc::RakeTask.new(:doc) do |task|
  task.options[:cookbook_dir] = './'
  task.options[:constraints] = true
  task.options[:output_file] = 'README.md'
end

Stove::RakeTask.new

task default: 'quick'

desc 'Run all of the quick tests.'
task :quick do
  Rake::Task['doc'].invoke
  Rake::Task['rubocop'].invoke
  Rake::Task['foodcritic'].invoke
  Rake::Task['spec'].invoke
end

desc 'Run _all_ the tests. Go get a coffee.'
task :complete do
  Rake::Task['quick'].invoke
  Rake::Task['kitchen:all'].invoke
end

desc 'Run CI tests'
task :ci do
  Rake::Task['complete'].invoke
end
