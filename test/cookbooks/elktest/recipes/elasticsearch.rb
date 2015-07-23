
elasticsearch 'default' do
  action [:install, :start, :enable]
end

elasticsearch_config 'default' do
  action :create
  notifies :restart, 'elasticsearch[default]'
end
