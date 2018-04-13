# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashFilter < LogstashConfig
    resource_name :logstash_filter

    def default_config_name
      "20_filter_#{name}.conf"
    end

    def default_template_source
      "logstash/filter/#{name}.conf.erb"
    end
  end
end
