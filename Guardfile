# frozen_string_literal: true

clearing :on

# For Emacs
ignore(/.*flycheck_/)
ignore(/#.*#/)

guard :bundler do
  watch('Gemfile')
end

group :main, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec', results_file: '/tmp/spec.result' do
    watch(%r{spec/.+_spec.rb})
    watch('spec/spec_helper.rb') { 'spec' }
    watch('libraries/matchers.rb') { 'spec' }
  end

  guard :rubocop, cli: %(-f fu -D), notification: true do
    watch(/.+\.rb$/)
    watch('Rakefile')
    watch('Guardfile')
    watch('Gemfile')
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :foodcritic, cli: '--epic-fail any --progress --chef-version 14', cookbook_paths: '.' do
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{templates/.+$})
    watch('metadata.rb')
  end
end
