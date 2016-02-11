#
# Cookbook Name:: jboss7
# Provider:: jboss_users
#
# Copyright 2014 Andrew DuFour
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This provider will add or remove users from the JBoss 7 management or application realm

# Support whyrun

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Create #{@new_resource}") do
      create_jboss_user
    end
  end
end

action :delete do
  if @current_resource.exists
    converge_by("Delete #{new_resource}") do
      delete_jboss_user
    end
  else
    Chef::Log.info "#{@current_resource} doesn't exist - can't delete."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::Jboss7User.new(@new_resource.name)
  @current_resource.user_name(@new_resource.user_name)
  @current_resource.password(@new_resource.password)

  @current_resource.exists = true if user_exists?(@current_resource.user_name)
end

private

USR_FILE_PATH = '/opt/jboss/standalone/configuration/mgmt-users.properties'.freeze

def user_exists?(name)
  cmd_str = "egrep ^#{name}\=.* #{USR_FILE_PATH}"
  cmd = Mixlib::ShellOut.new(cmd_str)
  cmd.environment['HOME'] = ENV.fetch('HOME', '/root')
  cmd.run_command
  begin
    cmd.error!
    true
  rescue
    false
  end
end

def create_jboss_user
  cmd_str = "echo #{@current_resource.name}=#{@current_resource.password} >> #{USR_FILE_PATH}"
  cmd = Mixlib::ShellOut.new(cmd_str)
  cmd.run_command

  Chef::Log.info "JBoss7_create_user: #{cmd_str}"
  Chef::Log.info "JBoss7_create_user: #{cmd.stdout}"

  new_resource.updated_by_last_action(true)
end

def delete_jboss_user
  cmd_str = "sed -i '/^#{@current_resource.name}\=.*/d' #{USR_FILE_PATH}"
  cmd = Mixlib::ShellOut.new(cmd_str)
  cmd.run_command

  Chef::Log.info "JBoss7_delete_user: #{cmd_str}"
  Chef::Log.info "JBoss7_delete_user: #{cmd.stdout}"

  new_resource.updated_by_last_action(true)
end
