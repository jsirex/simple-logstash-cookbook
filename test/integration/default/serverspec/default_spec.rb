# frozen_string_literal: true

require_relative 'spec_helper'

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

%w[logstash logstash-two].each do |svc|
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

# # Example for infrataster
# describe server(:public) do
#   describe http('http://host/') do
#     it 'responses with redirect to https' do
#       expect(response.headers['Location']).to eq('https://host/')
#     end
#
#     it 'response code is 301' do
#       expect(response.status).to eq(301)
#     end
#   end
#
#   describe http('https://host/', ssl: { verify: false }) do
#     it 'response code is 200' do
#       expect(response.status).to eq(200)
#     end
#   end
# end
