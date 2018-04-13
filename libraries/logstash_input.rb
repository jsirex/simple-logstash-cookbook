# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashInput < LogstashConfig
    resource_name :logstash_input

    def default_config_name
      "10_input_#{name}.conf"
    end

    def default_template_source
      "logstash/input/#{name}.conf.erb"
    end
  end
end
