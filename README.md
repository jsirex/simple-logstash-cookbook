# Description

This cookbook installs only logstash and provides few typical configurations.
It doesn't install or depends on java, apache, nginx, elasticsearch, kibana, etc...

It also skips lumberjack.

## Usage

Default recipe only creates user/group and arks logstash.
You are free to do anything with installation.

Also cookbook provides HWRPs for managing services and configs of logstash.
You can define multiple services and configs.

## HWRP

### logstash\_config

Generic HWRP for managing logstashs' configs. It also creates parent directory for your config.
You better want to use its child classes.

#### Actions

- **create** - default, creates new config
- **delete** - deletes config

#### Attributes

- **user** - sets owner of the config file. Defaults to `logstash`
- **group** - sets group of config file. Defaults to `logstash`
- **prefix_conf** - sets prefix configuration dir. Defaults to `/etc`
- **service** - sets logstash service name config belongs to. Defaults to `logstash`
- **config_dir** - sets logstash config dir with pipelines. Defaults to `conf.d`
- **config_name** - sets logstash config name. Defaults to `<name>.conf`
- **template_source** - sets config template to use. Defaults to `logstash/<name>.conf.erb`
- **template_mode** - sets mode on the config file. Defaults to `0640`
- **template_variables** - set variables for the config template. Defaults to `{}`

### logstash\_input

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config_name** - Defaults to `/etc/<service>/10_input_<name>.conf`
- **template_source** - Defaults to `logstash/input/<name>.conf.erb`

### logstash\_filter

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config_name** - Defaults to `/etc/<service>/20_filter_<name>.conf`
- **template_source** - Defaults to `logstash/filter/<name>.conf.erb`

### logstash\_output

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config_name** - Defaults to `/etc/<service>/90_output_<name>.conf`
- **template_source** - Defaults to `logstash/output/<name>.conf.erb`

### logstash\_service

Defines logstash service. Currentl supported implementations:

- **systemd**
- **runit**

Cookbook tries to use **systemd**, but fallbacks to the **runit**.

Consider:

- [Systemd Implementation](libraries/logstash_service_systemd.rb)
- [Runit Implementation](libraries/logstash_service_runit.rb)

## Example

You can visit fixture cookbook [simple-logstash-test](test/fixtures/cookbooks/simple-logstash-test)

# Requirements

## Platform:

* debian (>= 8.0)
* ubuntu (>= 16.0)
* centos (>= 7.0)

## Cookbooks:

* ark
* runit

# Attributes

* `node['logstash']['download_url']` -  Defaults to `https://artifacts.elastic.co/downloads/logstash/logstash-6.2.3.tar.gz`.
* `node['logstash']['checksum']` -  Defaults to `0c326917ce035543e44042e95042d2e6f80f5b9119f514dbe275b236b964cbe7`.
* `node['logstash']['version']` -  Defaults to `6.2.3`.
* `node['logstash']['user']` -  Defaults to `logstash`.
* `node['logstash']['group']` -  Defaults to `logstash`.
* `node['logstash']['prefix_root']` -  Defaults to `/opt`.

# Recipes

* simple-logstash::default - Installs/Configures simple-logstash. No less. No more.

# License and Maintainer

Maintainer:: Yauhen Artsiukhou (<jsirex@gmail.com>)

Source:: https://github.com/jsirex/simple-logstash-cookbook

Issues:: https://github.com/jsirex/simple-logstash-cookbook/issues

License:: Apache-2.0
