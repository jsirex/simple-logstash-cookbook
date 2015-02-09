# Do not include in run list this recipe
# It only for spec-testing and absolutely useless

# The same as in IT
logstash_output 'test1'
logstash_input 'test1'
logstash_filter 'test1'
logstash_input 'test2'
logstash_filter 'test2'
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
