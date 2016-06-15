#
# Cookbook Name:: centos-test
# Recipe:: nginx
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#Install and run nginx
package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

#Create root-directory for nginx
directory "/var/www/#{node['centos-test']['nginx_site']}" do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end


directory node['centos-test']['nginx_root'] do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end

#Create home page with phpinfo
file "#{node['centos-test']['nginx_root']}/index.php" do
  content '<?php phpinfo(); ?>'
	owner 'apache'
	group 'apache'
	mode 0644
end

#Editing nginx.conf for proxy path to nodejs & apache
template '/etc/nginx/nginx.conf' do
	source 'default.erb'
	owner 'root'
	group 'root'
	mode '0644'
  variables :nginx_root => node['centos-test']['nginx_root'],
						:nginx_site => node['centos-test']['nginx_site']
  notifies :restart, 'service[nginx]', :immediately
  notifies :restart, 'service[php-fpm]', :immediately
end
