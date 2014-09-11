#
# Cookbook Name:: solr-tomcat
# Recipe:: default
#
# Copyright 2010, Jiva Technology Ltd.
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

include_recipe "tomcat"
include_recipe "application"

tomcatService = "tomcat#{node['tomcat']['base_version']}"

remote_file node.solr.download do
  source   node.solr.link
  checksum node.solr.checksum
  mode     0644
  action :create_if_missing
end

bash 'unpack solr' do
  code   "tar xzf #{node.solr.download} -C #{node.solr.directory}"
  not_if "test -d #{node.solr.extracted}"
end

#  create log4j properties
template "#{node.solr.extracted}/log4j.properties" do
  source "log4j.properties.erb"
  action :create_if_missing
end

bash "Add required solr lib and deps to the war file" do
  code <<-EOH
  mkdir -p /tmp/solr-temp/WEB-INF/lib
  cd /tmp/solr-temp
  cp #{node.solr.extracted}/example/lib/ext/* WEB-INF/lib
  cp #{node.solr.extracted}/dist/solr-dataimporthandler-* WEB-INF/lib
  cp #{node.solr.extracted}/log4j.properties WEB-INF/lib
  jar -uvf #{node.solr.war} WEB-INF/lib 
  chmod +r #{node.solr.war}
  cd -
  rm -rf /tmp/solr-temp
  EOH
end

application "solr" do
    path node.solr.home
    owner node["tomcat"]["user"]
    group node["tomcat"]["group"]
    repository node.solr.war
    revision     "HEAD"
    scm_provider Chef::Provider::File::Deploy

    java_webapp do
        context_template "solr.context.erb"
    end

    tomcat
end

remote_directory node.solr.data do
  source       "solr"
  owner        node.tomcat.user
  group        node.tomcat.group
  files_owner  node.tomcat.user
  files_group  node.tomcat.group
  files_backup 0
  files_mode   "644"
  purge        true
  action       :create_if_missing
  recursive true
  notifies :run, "execute[change-permission-#{node.solr.data}]", :immediately
  not_if       { File.exists? node.solr.data }
end

execute "change-permission-#{node.solr.data}" do
  command "chown -R #{node.tomcat.user}:#{node.tomcat.group} #{node.solr.data}"
  user "root"
  action :nothing
end

