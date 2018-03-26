# frozen_string_literal: true

# this ensures that the systemd resource file is loaded before this one, thus
# making it the default resource for platforms provided for by both resources
require_relative 'logstash_service_systemd'

module SimpleLogstashCookbook
  class LogstashServiceRunit < LogstashServiceBase
    resource_name :logstash_service_runit

    LOGSTASH_INIT_STYLE = 'runit'

    provides :logstash_service, os: 'linux'
    provides :logstash_service_runit, os: 'linux'

    action_class do
      def whyrun_supported?
        true
      end

      def service_resource
        find_resource(:runit_service, new_resource.instance_name) do
          cookbook 'simple-logstash'
          default_logger true
          options(new_resource: new_resource)
          env new_resource.env
          sv_timeout new_resource.timeout_sec unless new_resource.timeout_sec.nil?

          action :nothing
        end
      end
    end

    action :start do
      service_resource.action += [:create, :enable, :start]
    end

    action :stop do
      service_resource.action += [:stop, :disable]
    end

    action :restart do
      service_resource.action += [:create, :enable, :restart]
    end
  end
end
