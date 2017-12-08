# frozen_string_literal: true

module SimpleLogstashCookbook
  # This reource manages logstash service
  class LogstashServiceBase < Chef::Resource
    property :instance_name, String, name_property: true, required: true, desired_state: false
    property :user, String, default: 'logstash', desired_state: false
    property :group, String, default: 'logstash', desired_state: false
    property :daemon_path, String, default: '/opt/logstash/bin/logstash', desired_state: false
    property :logstash_config_path, String, default: lazy { default_config_path }, desired_state: false
    property :logstash_plugin_path, String, desired_state: false
    property :logstash_filter_workers, Integer, default: 1, desired_state: false
    property :logstash_quiet, [true, false], default: true, desired_state: false
    property :logstash_verbose, [true, false], default: false, desired_state: false
    property :logstash_debug, [true, false], default: false, desired_state: false

    default_action :start
    allowed_actions :start, :stop, :restart

    def default_config_path
      "/etc/#{instance_name}"
    end

    def logstash_args
      args = []
      args << "-f #{logstash_config_path}"
      args << "-p #{logstash_plugin_path}" if logstash_plugin_path
      args << "-w #{logstash_filter_workers}"
      args << '--quiet' if logstash_quiet
      args << '--verbose' if logstash_verbose
      args << '--debug' if logstash_debug

      args.join(' ')
    end
  end
end
