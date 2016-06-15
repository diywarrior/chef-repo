#
# Cookbook Name:: centos-test
# Recipe:: firewall
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#Enable firewall from community cookbook/ allow ssh
include_recipe 'firewall::default'

#Open ports in firewall (80,8080, 8081)
ports = node.default['centos-test']['open_ports']
firewall_rule "open ports #{ports}" do
  port ports
end

#Close ports in firewall (21,25)
ports = node.default['centos-test']['close_ports']
firewall_rule "deny ports #{ports}" do
    port ports
    command :deny
end
