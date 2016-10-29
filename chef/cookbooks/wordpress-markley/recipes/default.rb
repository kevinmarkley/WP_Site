## See http://wp-cli.org/docs/installing/ for more info


include_recipe "yum-mysql-community::mysql56"

# yum_repository 'mysql56-community' do
#   mirrorlist 'http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/'
#   description 'MySQL Connectors Community'
#   name 'MySQL 5.6 Community Server'
#   enabled true
#   gpgcheck true
#   # gpgkey 'https://raw.githubusercontent.com/rs-services/equinix-public/master/cookbooks/db_mysql/files/centos/mysql_pubkey.asc'
# end

package 'mysql-devel'
# package 'php55-devel'

# include_recipe "wordpress"


# Download the wp-cli
execute "download wp-cli" do
  command "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
  user 'root'
  group 'root'
  action :run
end

# Make the tool executable
execute "make wp-cli executable" do
  command "chmod +x wp-cli.phar"
  user 'root'
  group 'root'
  action :run
end

# Move wp-cli
execute "move wp-cli" do
  command "mv wp-cli.phar /usr/local/bin/wp"
  user 'root'
  group 'root'
  action :run
end

# Update wp-admin
execute "update wp-admin" do
  command "wp core install --path=\"/var/www/wordpress\" --url=\"#{node['wordpress-markley']['server']}\"  --title=\"Kevin Markley WP\" --admin_user=\"#{node['wordpress-markley']['wp_user']}\" --admin_password=\"#{node['wordpress-markley']['wp_password']}\" --admin_email=\"#{node['wordpress-markley']['email']}\""
  user 'ec2-user'
  group 'ec2-user'
  action :run
end
