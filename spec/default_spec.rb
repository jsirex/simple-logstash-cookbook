require 'spec_helper'

describe 'simple-logstash::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
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

  # No matchers in 0.9.0 ark. Wait for new version
  #  it 'arks logstash archive' do
  #    expect(chef_run).to install_ark('logstash')
  #  end
end
