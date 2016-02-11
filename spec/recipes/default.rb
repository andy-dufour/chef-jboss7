require 'spec_helper'

describe 'jboss7::default' do
  ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  context 'When the recipe is run on Ubuntu 14.04' do
    it 'renders the init template' do
      expect(chef_run).to create_template('/etc/init.d/jboss7').with(
        owner: 'root',
        group: 'root',
        mode: 0644,
        source: '/jboss7-init.erb'
      )
    end
    it 'enables the JBoss service' do
      expect(chef_run).to enable_service('jboss7')
    end
    it 'starts the JBoss service' do
      expect(chef_run).to start_service('jboss7')
    end
  end
end
