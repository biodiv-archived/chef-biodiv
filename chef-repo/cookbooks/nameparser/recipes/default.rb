#
# Cookbook Name:: biodiv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install ruby
apt_package "ruby2.0" do
  action :install
end

# create user
#  create the user that runs nameparser
user node.nameparser.user do
  comment "nameparser user"
  system true
  shell "/bin/false"
end

#  create the group that runs nameparser
group node.nameparser.group do
  members node.nameparser.user
  append true
end

# create name parser home
directory node['nameparser']['home'] do
  recursive true
  owner node.nameparser.user
  group node.nameparser.group
  action :create
end

# install biodiversity gem
bash "install biodiversity gem" do
  code "gem2.0 install biodiversity"
  not_if "test -f #{node.nameparser.binary}"
end

# define the nameparser service
service "nameparser" do
   if platform?("ubuntu")
        provider Chef::Provider::Service::Upstart
   end

   action :nothing
   supports :status => true, :start => true, :stop => true, :restart => true
end

# upstart script
template "/etc/init/nameparser.conf" do
  source "nameparser-upstart.conf.erb"
        only_if { platform?("ubuntu") }
  notifies :restart, resources(:service => "nameparser"), :immediately
end

# init script
template "/etc/init.d/nameparser" do
  source "nameparser-init.erb"
        only_if { platform?("redhat", "centos", "fedora", "debian") }
  mode 0744
  notifies :restart, resources(:service => "nameparser"), :immediately
end

