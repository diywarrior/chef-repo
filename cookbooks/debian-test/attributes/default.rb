default['firewall']['allow_ssh'] = true
default['debian-test']['open_ports'] = [80, 8080, 8081]
default['debian-test']['close_ports'] = [21, 25]
default['debian-test']['php-root'] = '/var/www/example.com'
default['debian-test']['group'] = 'shell_users'
default['debian-test']['users'] = ['user1', 'user2', 'user3']
default['debian-test']['apache_site'] = 'example.com'
default['debian-test']['nodejs_root'] = '/usr/share/node'
default['debian-test']['node_app'] = 'helloworld'
default['debian-test']['nginx_root'] = '/usr/share/nginx/html'
default['debian-test']['nginx_site'] = 'test.org'
default['debian-test']['apache_port'] = '8081'
default['debian-test']['nodejs_port'] = '8080'
default['debian-test']['secret_path'] = '/tmp/kitchen/encrypted_data_bag_secret'
