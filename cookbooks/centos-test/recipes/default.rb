#
# Cookbook Name:: centos-test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node[:platform]
when 'centos', 'redhat', 'fedora'
#Set selinux to permissive mode
include_recipe 'selinux::permissive'
#Configure firewall
include_recipe 'centos-test::firewall'
#Create shell user-group and users with encrypted passwords
include_recipe 'centos-test::shell_users'
#Configure httpd, php, cteating home page with HelloWorld
include_recipe 'centos-test::php'
#Install node_js, create app with HelloWorld
include_recipe 'centos-test::node_js'
#Install and configure nginx as frontend to apache and nodejs
include_recipe 'centos-test::nginx'
when 'debian', 'ubuntu', 'opensuse', 'windows'
  return
end
