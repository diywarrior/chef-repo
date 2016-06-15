#
# Cookbook Name:: debian-test
# Recipe:: node_js
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#install package nodejs and npm
package 'nodejs'

package 'npm'

#Create home directory for node apps
directory node['debian-test']['nodejs_root'] do
   owner 'www-data'
   group 'www-data'
   mode 0755
   action :create
 end

#Create and start app with "HelloWorld"
 execute 'start_nodejs_app_permanently' do
   command "nodejs #{node['debian-test']['nodejs_root']}/#{node['debian-test']['node_app']}.js &"
   action :nothing
 end

template "#{node['debian-test']['nodejs_root']}/#{node['debian-test']['node_app']}.js" do
  source 'helloworld.js.erb'
  owner 'www-data'
  group 'www-data'
  mode 0644
  variables :nodejs_port => node['debian-test']['nodejs_port']
  notifies :run, "execute[start_nodejs_app_permanently]"
end
