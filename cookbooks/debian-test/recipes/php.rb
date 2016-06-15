#
# Cookbook Name:: debian-test
# Recipe:: php
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#Install apache2 and set it to run
package 'apache2'

service 'apache2' do
	action [:enable, :start]
end

#install modes for php
package 'libapache2-mod-fastcgi'

package 'php5-fpm'
service 'php5-fpm' do
	action [:enable, :start]
end

#change listen port in apache from 80 to 8081
template '/etc/apache2/ports.conf' do
  source 'ports.conf.erb'
	owner 'www-data'
	group 'www-data'
	mode 0644
	variables :apache_port => node['debian-test']['apache_port']
end

#change listen port in apache default site config
template '/etc/apache2/sites-available/000-default.conf' do
  source '000-default.conf.erb'
	owner 'www-data'
	group 'www-data'
	mode 0644
	variables :apache_port => node['debian-test']['apache_port']
end

#change php5-fpm config
template '/etc/apache2/conf-available/php5-fpm.conf' do
  source 'php5-fpm.conf.erb'
	owner 'www-data'
	group 'www-data'
	mode 0644
	notifies :restart, 'service[apache2]', :immediately
	notifies :restart, 'service[php5-fpm]', :immediately
end

#create root directory for site
directory "#{node['debian-test']['php-root']}" do
	owner 'www-data'
	group 'www-data'
	mode 0755
	action :create
end

#diable apache default site config
default_conf = '/etc/apache2/sites-enabled/000-default.conf'
link default_conf do
	action :delete
	only_if { File.exists?(default_conf) }
end

#Create our site config
template "/etc/apache2/sites-available/#{node['debian-test']['apache_site']}.conf" do
  source 'apache_site.conf.erb'
	owner 'www-data'
	group 'www-data'
	mode 0644
	variables :apache_site => node['debian-test']['apache_site']

end

#Enable our site
link "/etc/apache2/sites-enabled/#{node['debian-test']['apache_site']}.conf" do
	to "/etc/apache2/sites-available/#{node['debian-test']['apache_site']}.conf"
	notifies :restart, 'service[apache2]', :immediately
end

#Create home .php page with Helloworld
template "#{node['debian-test']['php-root']}/index.php" do
  source 'index.php.erb'
	owner 'www-data'
	group 'www-data'
	mode 0644
	notifies :restart, 'service[apache2]', :immediately
end
