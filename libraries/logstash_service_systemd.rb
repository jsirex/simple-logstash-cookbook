# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashServiceSystemd < LogstashServiceBase
    resource_name :logstash_service_systemd

    provides :logstash_service, platform: 'debian' do |node| # ~FC005
      node['platform_version'].to_f >= 8.0
    end

    provides :logstash_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f >= 15.04
    end

    provides :logstash_service, platform: %w[redhat centos scientific oracle] do |node|
      node['platform_version'].to_f >= 7.0
    end

    provides :logstash_service, platform: 'fedora'
    provides :logstash_service_systemd, os: 'linux'

    action_class do
      def env_file
        find_resource(:file, "/etc/default/#{new_resource.instance_name}") do
          content new_resource.env.map { |k, v| "#{k}=#{v}" }.join("\n")
          owner 'root'
          group 'root'
          mode '0644'
        end
      end

      def service_resource
        find_resource(:systemd_unit, "#{new_resource.instance_name}.service") do
          content(
            'Unit' => {
              'Description' => "Logstash #{new_resource.instance_name} service",
              'After' => 'network.target',
              'Documentation' => 'https://www.elastic.co/products/logstash'
            },
            'Service' => {
              'User' => new_resource.user,
              'Group' => new_resource.group,
              'ExecStart' => new_resource.logstash_exec,
              'EnvironmentFile' => env_file.path,
              'Restart' => 'always',
              'RestartSec' => '1 min',
              'LimitNICE' => 19,
              'LimitNOFILE' => new_resource.max_open_files
            },
            'Install' => {
              'WantedBy' => 'multi-user.target'
            }
          )

          triggers_reload true

          action :nothing
        end
      end
    end

    action :start do
      data_directory.action += [:create]
      log_directory.action += [:create]
      env_file.notifies :restart, service_resource, :delayed
      service_resource.action += [:create, :enable]
      service_resource.notifies :restart, service_resource, :delayed
    end

    action :stop do
      service_resource.action += [:stop, :disable]
    end

    action :restart do
      service_resource.action += [:restart]
    end
  end
end
