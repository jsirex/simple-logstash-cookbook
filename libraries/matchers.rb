# frozen_string_literal: true

if defined?(ChefSpec)
  # matcher => [methods]
  {
    :logstash_config => %w[create delete],
    :logstash_input => %w[create delete],
    :logstash_filter => %w[create delete],
    :logstash_output => %w[create delete]
  }.each_pair do |resource, actions|
    ChefSpec.define_matcher resource

    actions.each do |action|
      define_method("#{action}_#{resource}") do |resource_name|
        ChefSpec::Matchers::ResourceMatcher.new(resource, action.to_sym, resource_name)
      end
    end
  end
end
