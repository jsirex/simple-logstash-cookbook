# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashConfig < Chef::Resource
    resource_name :logstash_config

    property :user, String, default: 'logstash', desired_state: false
    property :group, String, default: 'logstash', desired_state: false

    property :prefix_conf, String, default: '/etc', desired_state: false
    property :service, String, default: 'logstash', desired_state: false

    property :config_dir, String, default: 'conf.d', desired_state: false
    property :config_name, String, default: lazy { default_config_name }, desired_state: false

    property :template_source, String, default: lazy { default_template_source }, desired_state: false
    property :template_mode, String, default: '0640', desired_state: false
    property :template_variables, Hash, default: {}, desired_state: false

    default_action :create
    allowed_actions :create, :delete

    def default_config_name
      "#{name}.conf"
    end

    def default_template_source
      "logstash/#{name}.conf.erb"
    end

    def full_config_path
      ::File.join(prefix_conf, service, config_dir, config_name)
    end

    action_class do
      def conf_dir
        find_resource(:directory, ::File.dirname(new_resource.full_config_path)) do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true

          action :nothing
        end
      end

      def conf_file
        find_resource(:template, new_resource.full_config_path) do
          path new_resource.full_config_path
          source new_resource.template_source
          cookbook new_resource.cookbook_name
          owner new_resource.user
          group new_resource.group
          mode new_resource.template_mode
          variables new_resource.template_variables

          action :nothing
        end
      end
    end

    action :create do
      conf_dir.action += [:create]
      conf_file.action += [:create]
    end

    action :delete do
      conf_file.action += [:delete]
    end
  end
end
