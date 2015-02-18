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

- **service** - logstash service name config belongs to. Defaults to `logstash`
- **config** - logstash config file name to create. Defaults to `node['logstash']['prefix_conf']/<service>/<name>.conf`
- **source** - config template to use. Defaults to `logstash/<name>.conf.erb`
- **owner** - set owner of config file. Defaults to `node['logstash']['user']`
- **group** - set group of config file. Defaults to `node['logstash']['group']`
- **mode** - set group of config file. Defaults to `0640`
- **variables** - set variables for config template. Defaults to `{}`

### logstash\_input

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config** - Defaults to `node['logstash']['prefix_conf']/<service>/10_input_<name>.conf`
- **source** - Defaults to `logstash/input/<name>.conf.erb`

### logstash\_filter

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config** - Defaults to `node['logstash']['prefix_conf']/<service>/20_filter_<name>.conf`
- **source** - Defaults to `logstash/filter/<name>.conf.erb`

### logstash\_output

This resource based on *logstash\_config*. It has the same actions and attributes.
But it has some different default values:

- **config** - Defaults to `node['logstash']['prefix_conf']/<service>/90_output_<name>.conf`
- **source** - Defaults to `logstash/output/<name>.conf.erb`

### logstash\_service

Defines logstash service based on **runit** HWRP.

#### Actions

Actions are same as in **runit** HWRP. Use this resource as you use **runit**

#### Attributes

- **logstash\_config\_path** - Defaults to `node['logstash']['prefix_conf']/<servicename>`
- **logstash\_plugin\_path** - Defaults to `nil`
- **logstash\_filter\_workers** - Defaults to `1`
- **logstash\_quiet** - Defaults to `true`
- **logstash\_verbose** - Defaults to `false`
- **logstash\_debug** - Defaults to `false`

## Example

You can visit fixture cookbook [test-logstash](test/fixtures/cookbooks/test-logstash)
