# frozen_string_literal: true

require 'spec_helper'

describe 'simple-logstash-test::default' do
  let(:platform) { 'debian' }
  let(:platform_version) { '9.1' }
  let(:node_attributes) { {} }

  let(:runner_options) do
    {
      platform: platform,
      version: platform_version,
      step_into: %w[logstash_service]
    }
  end

  let(:runner) do
    ChefSpec::SoloRunner.new(**runner_options) do |node|
      node_attributes.each { |k, v| node.override['logstash'][k] = v }
    end
  end

  let(:chef_run) do
    runner.converge(described_recipe)
  end

  it 'enables logstash service' do
    expect(chef_run).to start_logstash_service('logstash')
  end

  it 'enables logstash-two service' do
    expect(chef_run).to start_logstash_service('logstash-two')
  end

  it 'uses the systemd provider by default' do
    expect(chef_run).to start_systemd_unit('logstash.service')
    expect(chef_run).to start_systemd_unit('logstash-two.service')
  end

  %w[test1 test2 test3].each do |tst|
    it "creates logstash input for #{tst}" do
      expect(chef_run).to create_logstash_input(tst)
    end

    it "creates logstash filter for #{tst}" do
      expect(chef_run).to create_logstash_filter(tst)
    end
  end

  %w[test1 test3].each do |tst|
    it "creates logstash output for #{tst}" do
      expect(chef_run).to create_logstash_output(tst)
    end
  end

  it 'creates samples directory for tests' do
    expect(chef_run).to create_remote_directory('/tmp/samples')
  end

  context 'on ubuntu 14.04' do
    let(:platform) { 'ubuntu' }
    let(:platform_version) { '14.04' }

    it 'enables logstash service' do
      expect(chef_run).to start_logstash_service('logstash')
    end

    it 'uses the runit provider, since systemd does not exist on ubuntu 14.04' do
      expect(chef_run).to start_runit_service('logstash')
    end

    it 'includes the runit default recipe' do
      expect(chef_run).to include_recipe('runit')
    end
  end

  context 'when explicitly asked to use runit' do
    let(:node_attributes) { { 'init_style' => 'runit' } }

    it 'does so' do
      expect(chef_run).to start_runit_service('logstash')
    end

    it 'includes the runit default recipe' do
      expect(chef_run).to include_recipe('runit')
    end
  end
end
