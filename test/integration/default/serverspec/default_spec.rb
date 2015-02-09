require 'serverspec'

set :backend, :exec

describe process('java') do
  it { should be_running }
end

describe command('/opt/logstash/bin/logstash -t -f /etc/logstash') do
  its(:exit_status) { should eq 0 }
end

describe command('/opt/logstash/bin/logstash -t -f /etc/logstash-two') do
  its(:exit_status) { should eq 0 }
end

describe command('ls /opt/logstash/.sincedb_*') do
  its(:exit_status) { should eq 0 }
end

%w(logstash logstash-two).each do |svc|
  describe command("/etc/init.d/#{svc} status") do
    its(:exit_status) { should eq 0 }
  end
end

[
  # Configs
  '/etc/logstash/10_input_test1.conf',
  '/etc/logstash/10_input_test2.conf',
  '/etc/logstash/20_filter_test1.conf',
  '/etc/logstash/20_filter_test2.conf',
  '/etc/logstash/90_output_test1.conf',
  '/etc/logstash-two/10_input_test3.conf',
  '/etc/logstash-two/20_filter_test3.conf',
  '/etc/logstash-two/90_output_test3.conf',
  # Produced files
  '/tmp/result_test1.logstash',
  '/tmp/result_test3.logstash'
].each do |f|
  describe file(f) do
    it { should be_file }
  end
end

