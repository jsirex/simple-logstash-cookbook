# frozen_string_literal: true

# Default: systemd
logstash_service 'systemd-default'

# Explicit
logstash_service_systemd 'systemd-explicit'
logstash_service_runit 'runit-explicit'

# Via provider
logstash_service 'systemd-provider' do
  provider :logstash_service_systemd
end

logstash_service 'runit-provider' do
  provider :logstash_service_runit
end
