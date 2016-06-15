#
# Cookbook Name:: debian-test
# Recipe:: nginx
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#Install nginx
package 'nginx'

#Disable default configuration for nginx
link '/etc/nginx/sites-enabled/default' do
	action :delete
end

# Making services nginx and php5-fpm running and make them autostart
service 'nginx' do
	action [:enable, :start]
end

#Create home page for nginx with php-info
file "#{node['debian-test']['nginx_root']}/index.php" do
  content '<?php phpinfo(); ?>'
	owner 'www-data'
	group 'www-data'
	mode 0644
end

#Configuring nginx-web server to proxy pass
template "/etc/nginx/sites-available/#{node['debian-test']['nginx_site']}" do
	source 'default.erb'
	owner 'www-data'
	group 'www-data'
	mode '0644'
	variables :nginx_root => node['debian-test']['nginx_root'],
						:nginx_site => node['debian-test']['nginx_site']
end

#Enable site config
link "/etc/nginx/sites-enabled/#{node['debian-test']['nginx_site']}" do
	to "/etc/nginx/sites-available/#{node['debian-test']['nginx_site']}"
	notifies :restart, 'service[nginx]', :immediately
end
