describe file('/etc/systemd/system/logstash.service') do
  it { should exist }

  systemd_config = [
    '\[Unit\]',
    'Description = Logstash service',
    'After = network\.target',
    'Documentation = https://www.elastic.co/products/logstash',
    '',
    '\[Service\]',
    'User = logstash',
    'Group = logstash',
    'ExecStart = /opt/logstash/bin/logstash --path\.config /etc/logstash/conf\.d --path\.data /var/lib/logstash/data --path\.logs /var/log/logstash --pipeline\.workers 1 --config\.reload.automatic --log\.level error',
    'EnvironmentFile = /etc/default/logstash',
    'Restart = always',
    'RestartSec = 1 min',
    'LimitNICE = 19',
    'LimitNOFILE = 16384',
    '',
    '\[Install\]',
    'WantedBy = multi-user\.target',
  ]
  its('content') { should match(%r{^#{systemd_config.join('\n')}$})}
end



describe command('/opt/logstash/bin/logstash --config.test_and_exit -f /etc/logstash/conf.d') do
  its(:exit_status) { should eq 0 }
end

describe service('logstash') do
  it { should be_enabled }
  it { should be_running }
end
