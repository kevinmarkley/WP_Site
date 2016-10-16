include_recipe 'tar'

tar_extract '/vagrant/file.tar.gz' do
  target_dir '/tmp/file'
  action :extract_local
end
