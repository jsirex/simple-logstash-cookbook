# frozen_string_literal: true

describe command('/opt/logstash/bin/logstash -t -f /etc/logstash/conf.d') do
  its(:exit_status) { should eq 0 }
end

describe command('/opt/logstash/bin/logstash -t -f /etc/logstash-two/conf.d') do
  its(:exit_status) { should eq 0 }
end

# describe command('ls /opt/logstash/.sincedb_*') do
#   its(:exit_status) { should eq 0 }
# end

%w[logstash logstash-two].each do |svc|
  describe runit_service(svc) do
    it { should be_enabled }
    it { should be_running }
  end
end

[
  '/var/lib/logstash',
  '/var/lib/logstash-custom-data-path',
  '/var/log/logstash',
  '/var/log/logstash-two'
].each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end

[
  # Configs
  '/etc/logstash/conf.d/10_input_test1.conf',
  '/etc/logstash/conf.d/10_input_test2.conf',
  '/etc/logstash/conf.d/20_filter_test1.conf',
  '/etc/logstash/conf.d/20_filter_test2.conf',
  '/etc/logstash/conf.d/90_output_test1.conf',
  '/etc/logstash-two/conf.d/10_input_test3.conf',
  '/etc/logstash-two/conf.d/20_filter_test3.conf',
  '/etc/logstash-two/conf.d/90_output_test3.conf',
  # Produced files
  '/tmp/result_test1.logstash',
  '/tmp/result_test3.logstash'
].each do |f|
  describe file(f) do
    it { should be_file }
  end
end
