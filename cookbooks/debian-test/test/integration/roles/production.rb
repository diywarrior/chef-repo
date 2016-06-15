name "production"
description "Role to configure production web-servers, running on debian- and rhel- based OS"
run_list "recipe[debian-test]", "recipe[centos-test]"
