# frozen_string_literal: true

module SimpleLogstashCookbook
  class LogstashServiceRunit < LogstashServiceBase
    resource_name :logstash_service_runit

    provides :logstash_service, platform: 'debian' do |node| # ~FC005
      node['platform_version'].to_f < 8.0
    end

    provides :logstash_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f < 15.04
    end

    provides :logstash_service, platform: %w[redhat centos scientific oracle] do |node|
      node['platform_version'].to_f < 7.0
    end

    provides :logstash_service_runit, os: 'linux'

    action_class do
      def service_resource
        find_resource(:runit_service, new_resource.instance_name) do
          cookbook 'simple-logstash'
          run_template_name 'logstash'
          default_logger true
          options :name => new_resource.instance_name,
                  :max_open_files => new_resource.max_open_files,
                  :user => new_resource.user,
                  :group => new_resource.group,
                  :exec => new_resource.logstash_exec

          env new_resource.env
          # sv_timeout new_resource.timeout_sec unless new_resource.timeout_sec.nil?

          action :nothing
        end
      end
    end

    action :start do
      data_directory.action += [:create]
      log_directory.action += [:create]
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
