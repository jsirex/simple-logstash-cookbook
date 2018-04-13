# frozen_string_literal: true

require 'spec_helper'

describe 'simple-logstash-spec::logstash_service' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'debian', version: '9.2') do |node|
    end.converge(described_recipe)
  end

  context 'when default' do
    it 'uses systemd service' do
      lservice = chef_run.logstash_service('systemd-default')
      expect(lservice.resource_name).to eq(:logstash_service_systemd)
      expect(lservice.action).to include(:start)
    end
  end

  context 'when explicit resource' do
    it 'uses systemd' do
      lservice = chef_run.logstash_service_systemd('systemd-explicit')
      expect(lservice.resource_name).to eq(:logstash_service_systemd)
      expect(lservice.action).to include(:start)
    end

    it 'uses runit' do
      lservice = chef_run.logstash_service_runit('runit-explicit')
      expect(lservice.resource_name).to eq(:logstash_service_runit)
      expect(lservice.action).to include(:start)
    end
  end

  context 'when spicified by provider' do
    it 'uses systemd' do
      lservice = chef_run.logstash_service('systemd-provider')
      provider = lservice.provider_for_action(:nothing).class.to_s
      expect(lservice.action).to include(:start)
      expect(provider).to match('SimpleLogstashCookbook::LogstashServiceSystemd')
    end

    it 'uses runit' do
      lservice = chef_run.logstash_service('runit-provider')
      provider = lservice.provider_for_action(:nothing).class.to_s
      expect(lservice.action).to include(:start)
      expect(provider).to match('SimpleLogstashCookbook::LogstashServiceRunit')
    end
  end
end
