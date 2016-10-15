## See https://docs.chef.io/install_server.html for more info

execute "Download and install chef" do
  command "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-server"
  user 'root'
  group 'root'
  action :run
  not_if "rpm -qa | grep chef-server-core"
end

# Allows us to stop service to make chagnes
execute "reconfigure chef server" do
  command "chef-server-ctl reconfigure"
  user 'root'
  group 'root'
  action :run
end

# Create an admin account
execute "create admin account" do
  command "chef-server-ctl user-create #{node['chef-server-markley']['chef_user_name']} #{node['chef-server-markley']['chef_admin_first_name']} #{node['chef-server-markley']['chef_admin_last_name']} #{node['chef-server-markley']['chef_admin_email']} '#{node['chef-server-markley']['chef_admin_password']}' --filename #{node['chef-server-markley']['chef_private_key']}"
  user 'root'
  group 'root'
  action :run
  not_if "chef-server-ctl user-list | grep #{node['chef-server-markley']['chef_user_name']}"
end

# Create a chef organization
execute "create a chef org" do
  command "chef-server-ctl org-create #{node['chef-server-markley']['chef_short_org']} '#{node['chef-server-markley']['chef_full_org']}' --association_user #{node['chef-server-markley']['chef_user_name']} --filename #{node['chef-server-markley']['chef_validator_key']}"
  user 'root'
  group 'root'
  action :run
  not_if "chef-server-ctl org-list | grep #{node['chef-server-markley']['short_org']}"
end

# Create a chef organization
execute "create a chef org" do
  command "chef-server-ctl org-create #{node['chef-server-markley']['chef_short_org']} '#{node['chef-server-markley']['chef_full_org']}' --association_user #{node['chef-server-markley']['chef_user_name']} --filename #{node['chef-server-markley']['chef_validator_key']}"
  user 'root'
  group 'root'
  action :run
  not_if "chef-server-ctl org-list | grep #{node['chef-server-markley']['chef_short_org']}"
end

# Run the reconfigure again on the chef server to install license and certs
execute "reconfigure chef server" do
  command "chef-server-ctl reconfigure"
  user 'root'
  group 'root'
  action :run
  not_if "rpm -qa | grep chef-manage"
end

# Configure the manager on the chef server
execute "Add manager to the chef server" do
  command "chef-server-ctl reconfigure --accept-license"
  user 'root'
  group 'root'
  action :run
  not_if "rpm -qa | grep chef-manage"
end

# Copy cert files to /tmp
%w{markley-chef.pem markley-validator.pem}.each do |cert|
  execute "cp /root/#{cert} /tmp/#{cert}" do
    user 'root'
    group 'root'
    action :run
    not_if { ::File.exists?("/tmp/#{cert}") }
  end
end

# Upload cookbooks
# %w{chef_handler windows 7-zip build-essential chef-sugar xml yum yum-epel iis yum-mysql-community rbac smf mysql php openssl apache2 apt postgresql database mariadb mysql2_chef_gem tar compat_resource rsyslog bluepill ohai packagecloud runit nginx php-fpm selinux wordpress wordpress-markley}.each do |cookbook|
#   execute "knife cookbook upload #{cookbook}" do
#     cwd '/cookbooks'
#     user 'root'
#     group 'root'
#     action :run
#   end

execute "knife cookbook upload wordpress-markley" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload runit" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload nginx" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload php-fpm" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload selinux" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload wordpress" do
    cwd '/cookbooks'
    user 'root'
    group 'root'
    action :run
  end

execute "knife cookbook upload packagecloud" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload ohai" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload bluepill" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload compat_resource" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload tar" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload mysql2_chef_gem" do
    cwd '/cookbooks'
    user 'root'
    group 'root'
    action :run
  end

execute "knife cookbook upload database" do
    cwd '/cookbooks'
    user 'root'
    group 'root'
    action :run
  end

execute "knife cookbook upload postgresql" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload apt" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload apache2" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload openssl" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload php" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload mysql" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload smf" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload rbac" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload yum-mysql-community" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload iis" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload yum-epel" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload yum" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload xml" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload chef-sugar" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload build-essential" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload 7-zip" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload windows" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end

execute "knife cookbook upload chef_handler" do
  cwd '/cookbooks'
  user 'root'
  group 'root'
  action :run
end