class Chef
  class Resource
    # Logstash Config resource
    # Provides generic functionality for:
    # * Chef::Resource::LogstashInput
    # * Chef::Resource::LogstashFilter
    # * Chef::Resource::LogstashOutput
    class LogstashConfig < Chef::Resource
      def initialize(name, run_context = nil)
        super

        @resource_name = :logstash_config
        @provider = Chef::Provider::LogstashConfig

        @action = :create
        @allowed_actions = [:create, :delete]

        @cookbook = nil
        @service = nil
        @config = nil
        @source = nil
        @owner = nil
        @group = nil
        @mode = nil
        @variables = nil

        @lga = node && node['logstash'] || {}
      end

      def cookbook(arg = nil)
        set_or_return(:cookbook, arg, :kind_of => String)
      end

      def service(arg = nil)
        set_or_return(:service, arg, :kind_of => String)
      end

      def config(arg = nil)
        set_or_return(:config, arg, :kind_of => String)
      end

      def source(arg = nil)
        set_or_return(:source, arg, :kind_of => String)
      end

      def owner(arg = nil)
        set_or_return(:owner, arg, :kind_of => String)
      end

      def group(arg = nil)
        set_or_return(:group, arg, :kind_of => String)
      end

      def mode(arg = nil)
        set_or_return(:mode, arg, :kind_of => String)
      end

      def variables(arg = nil)
        set_or_return(:variables, arg, :kind_of => Hash)
      end

      def after_created
        super

        @service ||= default_service
        @config ||= default_config
        @source ||= default_source
        @owner ||= default_owner
        @group ||= default_group
        @mode ||= default_mode
        @variables ||= default_variables

        notifies :restart, "logstash_service[#{service}]"
      end

      def default_config_name
        "#{name}.conf"
      end

      def default_service
        'logstash'
      end

      def default_config
        ::File.join(@lga['prefix_conf'] || '/etc', service, default_config_name)
      end

      def default_source
        "logstash/#{name}.conf.erb"
      end

      def default_owner
        @lga['user'] || 'logstash'
      end

      def default_group
        @lga['group'] || 'logstash'
      end

      def default_mode
        '0640'
      end

      def default_variables
        {}
      end
    end
  end
end
