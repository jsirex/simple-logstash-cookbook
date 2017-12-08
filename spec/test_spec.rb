# frozen_string_literal: true

require 'spec_helper'

describe 'simple-logstash-test::default' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'debian', version: '7.11').converge(described_recipe)
  end

  it 'enables logstash service' do
    expect(chef_run).to enable_logstash_service('logstash')
  end

  it 'enables logstash-two service' do
    expect(chef_run).to enable_logstash_service('logstash-two')
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
end
