class Chef
  class Resource
    # Resource for Logstash Filter Config
    # After Inputs but before Outputs. Prefxing '20_filter_' to the name
    class LogstashFilter < LogstashConfig
      def initialize(name, run_context = nil)
        super

        @resource_name = :logstash_filter
      end

      def default_config_name
        "20_filter_#{name}.conf"
      end

      def default_source
        "logstash/filter/#{name}.conf.erb"
      end
    end
  end
end
