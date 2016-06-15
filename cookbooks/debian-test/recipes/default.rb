#
# Cookbook Name:: debian-test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

case node[:platform]
when 'debian', 'ubuntu', 'opensuse'
# Updating apt-cache
include_recipe 'apt::default'
#Configuring firewall. Open ports: 80 - for nginx, 8081 - for Apache, 8080 - for Node.js. Close 21,25 ports
include_recipe 'debian-test::firewall'
#Create and configure user group and 3 test shell users with encrypted passwords
include_recipe 'debian-test::shell_users'
# Install Apache2 and php-modules. Configure config-files and create home page on .php with Hello world
include_recipe 'debian-test::php'
#Install Nodejs with npm module. Create app "Helloworld.js" and set it run
include_recipe 'debian-test::node_js'
#Install nginx, configure locations with proxy pass to nodejs and apache
include_recipe 'debian-test::nginx'
when 'centos', 'redhat', 'fedora', 'windows'
  return
end
