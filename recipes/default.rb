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

jboss_home = node['jboss7']['jboss_home']
jboss_user = node['jboss7']['jboss_user']

tarball_name = node['jboss7']['dl_url'].
	split('/')[-1].
	sub!('.tar.gz','')

user jboss_user do
	action :create
	comment "jboss User"
	home "/home/#{jboss_user}"
	shell "/bin/bash"
	supports :manage_home => true 
end

remote_file "#{jboss_home}/#{tarball_name}.tar.gz" do
  owner "root"
  group "root"
  mode "0644"
  source node['jboss7']['dl_url']
  notifies :run, "execute[untar-jboss]", :immediately
end

directory "#{jboss_home}/#{tarball_name}" do
	owner jboss_user
	group jboss_user
	mode "0755"
	recursive true
end

execute "untar-jboss" do
	cwd node['jboss7']['jboss_home']
	command "tar -xzf #{tarball_name}.tar.gz;chown -R #{jboss_user}.#{jboss_user} #{tarball_name}"
	creates "#{jboss_home}/#{tarball_name}/standalone/config/standalone.xml"
	action :nothing
end

link "#{jboss_home}/jboss" do
	to "#{jboss_home}/#{tarball_name}"
end

template "/etc/init.d/jboss" do
  source "jboss-init-debian.erb"
  mode 0775
  owner "root"
  group "root"
  variables({
	:jboss_user => node[:jboss7][:jboss_user]
  })
  notifies :enable, "service[jboss]", :delayed
  notifies :restart, "service[jboss]", :delayed
end

service 'jboss' do
  provider Chef::Provider::Service::Init::Debian
  restart_command "/etc/init.d/jboss stop; sleep 10; nohup /etc/init.d/jboss start >/dev/null 2>&1 &"
  start_command "nohup /etc/init.d/jboss start >/dev/null 2>&1 &"
  action [ :nothing ]
end