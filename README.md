# Description

This cookbook installs only logstash and provide few typical configurations.
It doesn't install or depends on java, apache, nginx, elasticsearch, kibana, etc...

It also skips lumberjack.

# Requirements

## Platform:

* Debian
* Ubuntu
* Centos

## Cookbooks:

* ark
* runit

# Attributes

* `node['logstash']['download_url']` -  Defaults to `"https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz"`.
* `node['logstash']['checksum']` -  Defaults to `"d5be171af8d4ca966a0c731fc34f5deeee9d7631319e3660d1df99e43c5f8069"`.
* `node['logstash']['version']` -  Defaults to `"1.4.2"`.
* `node['logstash']['user']` -  Defaults to `"logstash"`.
* `node['logstash']['group']` -  Defaults to `"logstash"`.
* `node['logstash']['prefix_root']` -  Defaults to `"/opt"`.
* `node['logstash']['prefix_conf']` -  Defaults to `"/etc"`.

# Recipes

* simple-logstash::default

# License and Maintainer

Maintainer:: Yauhen Artsiukhou (<jsirex@gmail.com>)

License:: Apache
