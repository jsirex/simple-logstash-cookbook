class Chef
  class Resource
    # Resource for Logstash Input Config
    # takes high precedense by prefixing '10_input_' to the name
    class LogstashInput < LogstashConfig
      def initialize(name, run_context = nil)
        super

        @resource_name = :logstash_input
      end

      def default_config_name
        "10_input_#{name}.conf"
      end

      def default_source
        "logstash/input/#{name}.conf.erb"
      end
    end
  end
end
