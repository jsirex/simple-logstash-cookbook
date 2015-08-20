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

# Test two (uses same output as test1)
logstash_input 'test2'
logstash_filter 'test2'

# Test three: another service
logstash_input 'test3' do
  service 'logstash-two'
end

logstash_output 'test3' do
  service 'logstash-two'
end

logstash_filter 'test3' do
  service 'logstash-two'
end

logstash_service 'logstash'
logstash_service 'logstash-two'
