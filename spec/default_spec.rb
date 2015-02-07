require 'spec_helper'

describe 'simple-logstash::default' do
  cached(:chef_run) { ChefSpec::ServerRunner.new.converge described_recipe }

  it 'creates user for logstash' do
    expect(chef_run).to create_user('logstash')
  end

  it 'creates group for logstash' do
    expect(chef_run).to create_group('logstash')
  end

  # No matchers in 0.9.0 ark. Wait for new version
  #  it 'arks logstash archive' do
  #    expect(chef_run).to install_ark('logstash')
  #  end

  # it 'create logstash config file' do
  #   expect(chef_run).to render_file('/opt/logstash/config/logstash.yml')
  # end

  # it 'starts runit service logstash' do
  #   expect(chef_run).to enable_runit_service('logstash')
  #   expect(chef_run).to start_runit_service('logstash')
  # end
end
