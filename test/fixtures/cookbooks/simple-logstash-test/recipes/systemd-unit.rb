# frozen_string_literal: true

include_recipe 'java'
include_recipe 'simple-logstash'

# Setup directory with few samples
remote_directory '/tmp/samples' do
  source 'samples'
  owner 'root'
  group 'root'
  mode '0777'
  files_mode '0644'
  files_owner 'root'
  files_group 'root'
end

# Test one
logstash_output 'test1'
logstash_input 'test1'
logstash_filter 'test1'

content = {
  'Unit' => {
    'Description' => "Logstash service",
    'After' => 'network.target',
    'Documentation' => 'https://www.elastic.co/products/logstash'
  },
  'Service' => {
    'User' => 'logstash',
    'Group' => 'logstash',
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

logstash_service 'logstash' do
  systemd_unit_hash content
end
