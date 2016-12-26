# frozen_string_literal: true
require 'serverspec'
require 'infrataster/rspec'

set :backend, :exec

# Try to find first non-loopback ip inside docker
ip = Socket.ip_address_list.find { |x| x.ip_address.include? '172.17' }

Infrataster::Server.define(:local, '127.0.0.1')
Infrataster::Server.define(:public, ip.ip_address)
