# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "diywarrior"
client_key               "#{current_dir}/diywarrior.pem"
validation_client_name   "po2-validator"
validation_key           "#{current_dir}/po2-validator.pem"
chef_server_url          "https://api.chef.io/organizations/po2"
cookbook_path            ["#{current_dir}/../cookbooks"]
