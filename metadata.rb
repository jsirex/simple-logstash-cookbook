# frozen_string_literal: true

name             'simple-logstash'
maintainer       'Yauhen Artsiukhou'
maintainer_email 'jsirex@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures simple-logstash. No less. No more.'
version          '1.0.2'

issues_url       'https://github.com/jsirex/simple-logstash-cookbook/issues'
source_url       'https://github.com/jsirex/simple-logstash-cookbook'

supports 'debian', '>= 8.0'
supports 'ubuntu', '>= 16.0'
supports 'centos', '>= 7.0'

depends 'ark'
depends 'runit'

chef_version '>= 12.6'

# Provided recipes
recipe 'simple-logstash::default', 'Installs/Configures simple-logstash. No less. No more.'
