if defined?(ChefSpec)

  def start_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :start, service)
  end

  def stop_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :stop, service)
  end

  def enable_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :enable, service)
  end

  def disable_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :disable, service)
  end

  def restart_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :restart, service)
  end

  def reload_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :reload, service)
  end

  def status_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :status, service)
  end

  def once_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :once, service)
  end

  def hup_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :hup, service)
  end

  def cont_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :cont, service)
  end

  def term_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :term, service)
  end

  def kill_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :kill, service)
  end

  def up_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :up, service)
  end

  def down_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :down, service)
  end

  def usr1_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :usr1, service)
  end

  def usr2_logstash_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:logstash_service, :usr2, service)
  end

end
