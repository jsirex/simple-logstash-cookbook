# frozen_string_literal: true

# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashOutput < LogstashConfig
    resource_name :logstash_output

    def default_config_name
      "90_output_#{name}.conf"
    end

    def default_template_source
      "logstash/output/#{name}.conf.erb"
    end
  end
end
