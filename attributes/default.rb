# frozen_string_literal: true

default['logstash']['download_url'] = 'https://artifacts.elastic.co/downloads/logstash/logstash-6.2.3.tar.gz'
default['logstash']['checksum'] = '0c326917ce035543e44042e95042d2e6f80f5b9119f514dbe275b236b964cbe7'
default['logstash']['version'] = '6.2.3'

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'
default['logstash']['prefix_root'] = '/opt'
