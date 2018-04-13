# frozen_string_literal: true

module SimpleLogstashCookbook
  # This reource manages logstash service
  class LogstashServiceBase < Chef::Resource
    property :instance_name, String, name_property: true, desired_state: false
    property :user, String, default: 'logstash', desired_state: false
    property :group, String, default: 'logstash', desired_state: false
    property :daemon_path, String, default: '/opt/logstash/bin/logstash', desired_state: false
    property :env, Hash, default: {}, desired_state: false

    property :config_path, String, default: lazy { default_config_path }, desired_state: false
    property :data_path, String, default: lazy { default_data_path }, desired_state: false
    property :logs_path, String, default: lazy { default_logs_path }, desired_state: false

    property :pipeline_workers, Integer, default: 1, desired_state: false

    property :max_open_files, Integer, default: 16384, desired_state: false
    property :custom_args, String, default: '', desired_state: false

    # Different versions may have different flag name. Let give possibility to override it
    property :config_path_flag, String, default: '--path.config', desired_state: false
    property :data_path_flag, String, default: '--path.data', desired_state: false
    property :logs_path_flag, String, default: '--path.logs', desired_state: false
    property :pipeline_workers_flag, String, default: '--pipeline.workers', desired_state: false

    default_action :start
    allowed_actions :start, :stop, :restart

    def default_config_path
      "/etc/#{instance_name}/conf.d"
    end

    def default_data_path
      "/var/lib/#{instance_name}/data"
    end

    def default_logs_path
      "/var/log/#{instance_name}"
    end

    def logstash_exec
      args = []
      args << daemon_path
      args << "#{config_path_flag} #{config_path}"
      args << "#{data_path_flag} #{data_path}"
      args << "#{logs_path_flag} #{logs_path}"
      args << "#{pipeline_workers_flag} #{pipeline_workers}"
      args << custom_args

      args.join(' ')
    end

    action_class do
      def data_directory
        find_resource(:directory, new_resource.data_path) do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true

          action :nothing
        end
      end

      def log_directory
        find_resource(:directory, new_resource.logs_path) do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true

          action :nothing
        end
      end
    end
  end
end
