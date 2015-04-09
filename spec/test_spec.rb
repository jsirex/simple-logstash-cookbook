require 'spec_helper'

describe 'test-logstash::_test' do
  cached(:chef_run) { ChefSpec::ServerRunner.new.converge described_recipe }

  it 'enables logstash service' do
    expect(chef_run).to enable_logstash_service('logstash')
  end

  it 'enables logstash-two service' do
    expect(chef_run).to enable_logstash_service('logstash-two')
  end

  %w(test1 test2 test3).each do |tst|
    it "creates logstash input for #{tst}" do
      expect(chef_run).to create_logstash_input(tst)
    end

    it "creates logstash filter for #{tst}" do
      expect(chef_run).to create_logstash_filter(tst)
    end
  end

  %w(test1 test3).each do |tst|
    it "creates logstash output for #{tst}" do
      expect(chef_run).to create_logstash_output(tst)
    end
  end
end
