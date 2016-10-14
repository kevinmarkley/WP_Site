chef-server-markley Cookbook



e.g. This cookbook makes your favorite breakfast sandwich.



Attributes

default['chef-server-markley']['chef_user_name'] = Main Chef User Name
default['chef-server-markley']['chef_admin_first_name'] = Chef Admin's first name
default['chef-server-markley']['chef_admin_last_name'] = 'Chef Admin's Last name
default['chef-server-markley']['chef_admin_email'] = Chef Admin's email
default['chef-server-markley']['chef_admin_password'] = Chef Admin's Pass
default['chef-server-markley']['chef_short_org'] = Your Chef Org short
default['chef-server-markley']['chef_full_org'] = 'Your Chef Org full

e.g.

chef-server::default

Key	Type	Description	Default
['my-chef-server']['bacon']	Boolean	whether to include bacon	true
Usage

my-chef-server::default

TODO: Write usage instructions for each cookbook.

e.g. Just include my-chef-server in your node's run_list:

{
  "name":"my_node",
  "run_list": [
    "recipe[chef-server-markleu]"
  ]
}
Contributing


License and Authors

Authors: Kevin Markley