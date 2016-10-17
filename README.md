Description

This repository contains a cloudformation template and chef cookbooks in order to deploy a wordpress site.

The cloudformation template will deploy a chef server that will upload the necessary cookbooks. Once that is complete, a second server is deployed and uses the chef server to deploy a wordpress site.

Requirements

WPAdmin - A wordpress user that will be used as the admin of the site. Default 'wpadmin'
WPAdminPass - A password used for the admin user of the site. Default 'wppass1'
WPAdminEmail - An email address that will be used for the admin user. Default 'kevinmarkley@gmail.com'
AllowHTTP - The cidr block to allow access to the wordpress site. The default is 0.0.0.0/0 which will allow all of the internet to access the site.


Amazon Linux
Required Cookbooks

my-chef-server
chef_handler
windows
7-zip
build-essential
chef-sugar
xml
yum
yum-epel
iis
yum-mysql-community
rbac
smf
mysql
php
openssl
apache2
apt
postgresql
database
mariadb
mysql2_chef_gem
tar
compat_resource
rsyslog
bluepill
ohai
packagecloud
runit
nginx
php-fpm
selinux
wordpress
my-wordpress
Attributes

Chef Cookbook Wrapper (chef-server-markley) attributes

Attributes

default['chef-server-markley']['chef_user_name'] = Main Chef User Name
default['chef-server-markley']['chef_admin_first_name'] = Chef Admin's first name
default['chef-server-markley']['chef_admin_last_name'] = 'Chef Admin's Last name
default['chef-server-markley']['chef_admin_email'] = Chef Admin's email
default['chef-server-markley']['chef_admin_password'] = Chef Admin's Pass
default['chef-server-markley']['chef_short_org'] = Your Chef Org short
default['chef-server-markley']['chef_full_org'] = 'Your Chef Org full

Wordpress Cookbook Wrapper (wordpress-markley) attributes

default['wordpress-markley']['WPAdmin'] Wordpress admin account, set in the template
default['wordpress-markley']['WPAdminPass'] = Wordpress admin passwprd, set in the template
default['wordpress-markley']['private_key'] = chef private key, generated in chef run
default['wordpress-markley']['validator_key'] = 'Chef validator key, generated in chef run
default['wordpress-markley']['short_org'] = Chef Orginization
default['wordpress-markley']['server'] Public IP of server.
default['wordpress-markley']['email'] = 'WPAdmin' email address set in template


Deploy the cloudformation template within AWS and supply the required parameters.

Output

Check the "Outputs" tab within cloudformation to see the URL of the wordpress site once the deployment is complete.