#
# Cookbook Name:: jboss7
# Recipe:: default
#
# Copyright (C) 2014 Andrew DuFour
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'java'

user node['jboss7']['jboss_user'] do
  comment 'jboss User'
  home node['jboss7']['jboss_home']
  system true
  shell '/bin/false'
end

ark 'jboss' do
  url node['jboss7']['dl_url']
  home_dir node['jboss7']['jboss_home']
  prefix_root node['jboss7']['jboss_path']
  owner node['jboss7']['jboss_user']
  version node['jboss7']['jboss_version']
end

template "#{node['jboss7']['jboss_home']}/standalone/configuration/standalone.xml" do
  source 'standalone_xml.erb'
  owner node['jboss7']['jboss_user']
  group node['jboss7']['jboss_user']
  mode '0644'
  notifies :restart, 'service[jboss]', :delayed
end

template "#{node['jboss7']['jboss_home']}/bin/standalone.conf" do
  source 'standalone_conf.erb'
  owner node['jboss7']['jboss_user']
  group node['jboss7']['jboss_user']
  mode '0644'
  notifies :restart, "service[jboss]", :delayed
end

dist_dir, conf_dir = value_for_platform_family(
  ['debian'] => %w{ debian default },
  ['rhel'] => %w{ redhat sysconfig },
)

template '/etc/jboss-as.conf' do
  source "#{dist_dir}/jboss-as.conf.erb"
  mode 0775
  owner 'root'
  group node['root_group']
  only_if { platform_family?("rhel") }
  notifies :restart, 'service[jboss]', :delayed
end

template '/etc/init.d/jboss' do
  source "#{dist_dir}/jboss-init.erb"
  mode 0775
  owner 'root'
  group node['root_group']
  notifies :enable, 'service[jboss]', :delayed
  notifies :restart, 'service[jboss]', :delayed
end

jboss7_user node['jboss7']['admin_user'] do
  password node['jboss7']['admin_pass']
  action :create
  notifies :restart, 'service[jboss]', :delayed
end

service 'jboss' do
  supports :restart => true
  action :nothing
end
