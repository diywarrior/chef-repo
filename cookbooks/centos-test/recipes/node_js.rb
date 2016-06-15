#
# Cookbook Name:: centos-test
# Recipe:: node_js
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#install Fedora repository
package 'epel-release'

#Install nodejs & npm
package 'nodejs'

package 'npm'

#Create root-directory for node app
directory node['centos-test']['nodejs_root'] do
   owner 'apache'
   group 'apache'
   mode 0755
   action :create
 end

#Starting app permanently (&)
 execute 'start_nodejs_app_permanently' do
   command "node #{node['centos-test']['nodejs_root']}/#{node['centos-test']['node_app']}.js &"
   action :nothing
 end

#Creating app with HelloWorld
 template "#{node['centos-test']['nodejs_root']}/#{node['centos-test']['node_app']}.js" do
   source 'helloworld.js.erb'
   owner 'apache'
   group 'apache'
   mode 0644
   variables :nodejs_port => node['centos-test']['nodejs_port']
   notifies :run, "execute[start_nodejs_app_permanently]"
 end
