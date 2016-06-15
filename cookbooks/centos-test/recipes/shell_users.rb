#
# Cookbook Name:: centos-test
# Recipe:: shell_users
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
shell_users_group = node['centos-test']['group']

group shell_users_group

#Assign a list of users to variable
users = node['centos-test']['users']

secret_path = node['centos-test']['secret_path']

#Create users with passwords from encrypted data bag, user home folders
users.each { |users|

shell_user = data_bag_item( shell_users_group, users, IO.read(secret_path))

password = shell_user['password'].strip

user users do
  supports :manage_home => true
  comment 'test user'
  home "/home/#{users}"
  group shell_users_group
  shell '/bin/bash'
  password password
end

directory "/home/#{users}" do
  owner users
  group shell_users_group
  mode 0755
  action :create
end
}
