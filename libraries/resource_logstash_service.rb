class Chef
  class Resource
    # Based on Runit Service Resource
    # Provides automatically configured service for logstash
    # Example: logstash_service 'logstash'
    class LogstashService < Chef::Resource::RunitService
      def initialize(name, run_context = nil)
        super

        @resource_name = :logstash_service
        @provider = Chef::Provider::Service::Logstash

        @cookbook = 'simple-logstash'
        @run_template_name = 'logstash'
        @default_logger = true

        @logstash_config_path = nil
        @logstash_plugin_path = nil
        @logstash_filter_workers = 1
        @logstash_quiet = true
        @logstash_verbose = false
        @logstash_debug = false

        @lga = node && node['logstash'] || {}
      end

      def logstash_config_path(arg = nil)
        set_or_return(:logstash_config_path, arg, :kind_of => String)
      end

      def logstash_plugin_path(arg = nil)
        set_or_return(:logstash_plugin_path, arg, :kind_of => String)
      end

      def logstash_filter_workers(arg = nil)
        set_or_return(:logstash_filter_workers, arg, :kind_of => Integer)
      end

      def logstash_quiet(arg = nil)
        set_or_return(:logstash_quiet, arg, :kind_of => [TrueClass, FalseClass])
      end

      def logstash_verbose(arg = nil)
        set_or_return(:logstash_verbose, arg, :kind_of => [TrueClass, FalseClass])
      end

      def logstash_debug(arg = nil)
        set_or_return(:logstash_debug, arg, :kind_of => [TrueClass, FalseClass])
      end

      def after_created
        super

        @logstash_config_path ||= default_config_path
        setup_options
      end

      def default_user
        @lga['user'] || 'logstash'
      end

      def default_home
        @lga['prefix_root'] ? ::File.join(@lga['prefix_root'], 'logstash') : '/opt/logstash'
      end

      def default_config_path
        @lga['prefix_conf'] ? ::File.join(@lga['prefix_conf'], name) : "/etc/#{name}"
      end

      def logstash_args
        args = []
        args << "--config #{logstash_config_path}"
        args << "--pluginpath #{logstash_plugin_path}" if logstash_plugin_path
        args << "--filterworkers #{logstash_filter_workers}"
        args << '--quiet' if logstash_quiet
        args << '--verbose' if logstash_verbose
        args << '--debug' if logstash_debug

        args
      end

      def setup_options
        @options = {
          'user' => default_user,
          'home' => default_home,
          'args' => logstash_args
        }
      end
    end
  end
end
