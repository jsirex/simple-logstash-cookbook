name             'simple-logstash'
maintainer       'Yauhen Artsiukhou'
maintainer_email 'jsirex@gmail.com'
license          'Apache 2'
description      'Installs/Configures simple-logstash. No less. No more.'
long_description 'Installs/Configures simple-logstash. No less. No more.'
issues_url       'https://github.com/jsirex/simple-logstash-cookbook/issues' if respond_to?(:issues_url)
source_url       'https://github.com/jsirex/simple-logstash-cookbook' if respond_to?(:source_url)
version          '0.2.4'

supports 'debian'
supports 'ubuntu'
supports 'centos'

depends 'ark'
depends 'runit', '>= 1.7.2'
