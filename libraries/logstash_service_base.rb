# frozen_string_literal: true

module SimpleLogstashCookbook
  # This reource manages logstash service
  class LogstashServiceBase < Chef::Resource
    property :instance_name, String, name_property: true, desired_state: false
    property :user, String, default: 'logstash', desired_state: false
    property :group, String, default: 'logstash', desired_state: false
    property :daemon_path, String, default: '/opt/logstash/bin/logstash', desired_state: false
    property :env, Hash, default: {}, desired_state: false
    property :timeout_sec, [Integer, NilClass], default: nil, desired_state: false
    property :logstash_config_path, String, default: lazy { default_config_path }, desired_state: false
    property :logstash_plugin_path, String, desired_state: false
    property :logstash_filter_workers, Integer, default: 1, desired_state: false
    property :logstash_pipeline_batch_size, [Integer, nil], default: 125, desired_state: false
    property :logstash_quiet, [true, false], default: true, desired_state: false
    property :logstash_verbose, [true, false], default: false, desired_state: false
    property :logstash_debug, [true, false], default: false, desired_state: false
    property :logstash_max_file_descriptors, Integer, default: 16384, desired_state: false

    default_action :start
    allowed_actions :start, :stop, :restart

    def self.provides(*args, **kwargs)
      super(*args, **kwargs) do |node|
        if node['logstash']['init_style'].nil? || node['logstash']['init_style'] == self::LOGSTASH_INIT_STYLE
          block_given? ? yield(node) : true
        else
          false
        end
      end
    end

    def default_config_path
      "/etc/#{instance_name}"
    end

    def full_logstash_command
      "#{daemon_path} #{logstash_args}"
    end

    def logstash_args
      args = []
      args << "-f #{logstash_config_path}"
      args << "-p #{logstash_plugin_path}" if logstash_plugin_path
      args << "-w #{logstash_filter_workers}"
      args << "-b #{logstash_pipeline_batch_size}" if logstash_pipeline_batch_size
      args << '--quiet' if logstash_quiet
      args << '--verbose' if logstash_verbose
      args << '--debug' if logstash_debug

      args.join(' ')
    end
  end
end
