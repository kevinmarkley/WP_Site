require 'spec_helper'

describe 'mysql_client_test::default on centos-5.11' do
  cached(:centos_511_client_57) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '5.11',
      step_into: 'mysql_client'
    ) do |node|
      node.set['mysql']['version'] = '5.7'
    end.converge('mysql_client_test::default')
  end

  # Resource in mysql_client_test::default
  context 'compiling the test recipe' do
    it 'creates mysql_client[default]' do
      expect(centos_511_client_57).to create_mysql_client('default')
    end
  end

  # mysql_service resource internal implementation
  context 'stepping into mysql_client[default] resource' do
    it 'installs package[default :create mysql-community-client]' do
      expect(centos_511_client_57).to install_package('default :create mysql-community-client')
        .with(package_name: 'mysql-community-client')
    end

    it 'installs package[default :create mysql-community-devel]' do
      expect(centos_511_client_57).to install_package('default :create mysql-community-devel')
        .with(package_name: 'mysql-community-devel')
    end
  end
end
