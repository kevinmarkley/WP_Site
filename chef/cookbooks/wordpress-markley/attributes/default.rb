default['wordpress-markley']['wp_user'] = node['cloud']['wp_user']
default['wordpress-markley']['wp_password'] = node['cloud']['wp_password']
default['wordpress-markley']['private_key'] = 'kmarkley-chef.pem'
default['wordpress-markley']['validator_key'] = 'kmarkley-validator.pem'
default['wordpress-markley']['short_org'] = 'kmarkley'
default['wordpress-markley']['server'] = node['cloud']['wp_server']
default['wordpress-markley']['email'] = node['cloud']['wp_email']

# Attributes to override
override['wordpress']['db']['mysql_version'] = '5.5'
override['wordpress']['db']['root_password'] = 'my_root_password'
override['wordpress']['db']['instance_name'] = 'default'
override['wordpress']['db']['name'] = "wordpressdb"
override['wordpress']['db']['user'] = node['cloud']['db_user']
override['wordpress']['db']['pass'] = nil
override['wordpress']['db']['prefix'] = 'wp_'
override['wordpress']['db']['host'] = 'localhost'

# override['php']['mysql']['package'] = 'php56-mysqlnd'
override['php']['packages'] = %w(php55 php55-devel php55-cli php-pear)
override['php']['mysql']['package'] = 'php55-mysqlnd'

override['wordpress']['server_name'] = node['fqdn']
override['wordpress']['server_aliases'] = [node['fqdn'], "wordpress"]