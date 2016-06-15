#
# Cookbook Name:: centos-test
# Recipe:: php
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#install&run apache and php modules
package 'httpd'

service 'httpd' do
  action [:enable, :start]
end

package 'php'

package 'php-fpm'

service 'php-fpm' do
  action [:enable, :start]
end

#Create apache root directory
directory "/var/www/#{node['centos-test']['httpd_site']}" do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end

directory node['centos-test']['httpd_root'] do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end
#Create home page with HelloWorld
template "#{node['centos-test']['httpd_root']}/index.php" do
  source 'index.php.erb'
  owner 'apache'
  group 'apache'
  mode 0644
end
#Create virtual host
directory '/etc/httpd/sites-available' do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end

directory '/etc/httpd/sites-enabled' do
  owner 'apache'
  group 'apache'
  mode 0755
  action :create
end

template "/etc/httpd/sites-available/#{node['centos-test']['httpd_site']}.conf" do
  source 'httpd_site.conf.erb'
  owner 'apache'
  group 'apache'
  mode 0644
  variables :httpd_port => node['centos-test']['httpd_port'],
            :httpd_site => node['centos-test']['httpd_site']
end

link "/etc/httpd/sites-enabled/#{node['centos-test']['httpd_site']}.conf" do
  to "/etc/httpd/sites-available/#{node['centos-test']['httpd_site']}.conf"
  notifies :restart, 'service[httpd]', :immediately
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :httpd_port => node['centos-test']['httpd_port']
  notifies :restart, 'service[httpd]', :immediately
end
