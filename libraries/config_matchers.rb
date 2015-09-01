if defined?(ChefSpec)

  def create_logstash_config(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_config, :create, name)
  end

  def delete_logstash_config(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_config, :delete, name)
  end

  def create_logstash_input(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_input, :create, name)
  end

  def delete_logstash_input(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_input, :delete, name)
  end

  def create_logstash_filter(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_filter, :create, name)
  end

  def delete_logstash_filter(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_filter, :delete, name)
  end

  def create_logstash_output(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_output, :create, name)
  end

  def delete_logstash_output(name)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_output, :delete, name)
  end
end
