# frozen_string_literal: true

default['logstash']['download_url'] = 'https://download.elastic.co/logstash/logstash/logstash-1.5.6.tar.gz'
default['logstash']['checksum'] = '812a809597c7ce00c869e5bb4f87870101fe6a43a2c2a6586f5cc4d1a4986092'
default['logstash']['version'] = '1.5.6'

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'
default['logstash']['prefix_root'] = '/opt'
default['logstash']['prefix_conf'] = '/etc'
