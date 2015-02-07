class Chef
  class Resource
    # Resource for Logstash Output Config
    # takes lowest precedense by prefixing '90_output_' to the name
    class LogstashOutput < LogstashConfig
      def initialize(name, run_context = nil)
        super

        @resource_name = :logstash_output
      end

      def default_config_name
        "90_output_#{name}.conf"
      end

      def default_source
        "logstash/output/#{name}.conf.erb"
      end
    end
  end
end
