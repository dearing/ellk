elasticsearch_service 'default' do
  action [:create, :start, :enable]
end

elasticsearch_config 'default' do
  action :create
  notifies :restart, 'elasticsearch_service[default]'
end
