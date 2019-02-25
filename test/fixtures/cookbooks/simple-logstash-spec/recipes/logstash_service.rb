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

content = {
  'Unit' => {
    'Description' => "Logstash service",
    'After' => 'network.target',
    'Documentation' => 'https://www.elastic.co/products/logstash'
  },
  'Service' => {
    'User' => 'Logstash',
    'Group' => 'Logstash',
    'ExecStart' => '/opt/logstash/bin/logstash --path.config /etc/logstash/conf.d --path.data /var/lib/logstash/data --path.logs /var/log/logstash --pipeline.workers 1 --config.reload.automatic --log.level error',
    'EnvironmentFile' => '/etc/default/logstash',
    'Restart' => 'always',
    'RestartSec' => '1 min',
    'LimitNICE' => 19,
    'LimitNOFILE' => '16384'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  },
}

logstash_service_systemd 'systemd-unit' do
  provider :logstash_service_systemd
  systemd_unit_hash content
end
