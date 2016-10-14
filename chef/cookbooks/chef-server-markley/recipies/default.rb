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
  command "chef-server-ctl user-create #{node['chef-server-markley']['chef_user_name']} #{node['chef-server-markley']['chef_admin_first_name']} #{node['chef-server-markley']['chef_admin_last_name']} #{node['chef-server-markley']['chef_admin_email']} '#{node['chef-server-markley']['chef_admin_password']}' --filename #{node['chef-server-markley']['chef_sprivate_key']}"
  user 'root'
  group 'root'
  action :run
  not_if "chef-server-ctl user-list | grep #{node['chef-server-markley']['chef_user_name']}"
end

# Create a chef organization
execute "create a chef org" do
  command "chef-server-ctl org-create #{node['my-chef-server']['short_org']} '#{node['my-chef-server']['full_org']}' --association_user #{node['my-chef-server']['user_name']} --filename #{node['my-chef-server']['validator_key']}"
  user 'root'
  group 'root'
  action :run
  not_if "chef-server-ctl org-list | grep #{node['my-chef-server']['short_org']}"
end

# Add the manager to the chef server
execute "Add manager to the chef server" do
  command "chef-server-ctl install chef-manage"
  user 'root'
  group 'root'
  action :run
  not_if "rpm -qa | grep chef-manage"
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
  command "chef-manage-ctl reconfigure --accept-license"
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
%w{chef_handler windows 7-zip build-essential chef-sugar xml yum yum-epel iis yum-mysql-community rbac smf mysql php openssl apache2 apt postgresql database mariadb mysql2_chef_gem tar compat_resource rsyslog bluepill ohai packagecloud runit nginx php-fpm selinux wordpress my-wordpress}.each do |cookbook|
  execute "knife cookbook upload #{cookbook}" do
    cwd '/cookbooks'
    user 'root'
    group 'root'
    action :run
  end
end