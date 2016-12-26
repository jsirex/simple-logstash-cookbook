# frozen_string_literal: true
require 'spec_helper'

describe 'simple-logstash::default' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'debian', version: '7.11') do |node|
      node.override['logstash']['user'] = 'lgu'
      node.override['logstash']['group'] = 'lgg'
    end.converge(described_recipe)
  end

  it 'creates user for logstash' do
    expect(chef_run).to create_user('lgu')
  end

  it 'creates group for logstash' do
    expect(chef_run).to create_group('lgg')
  end

  it 'arks logstash archive' do
    expect(chef_run).to install_ark('logstash')
  end
end
