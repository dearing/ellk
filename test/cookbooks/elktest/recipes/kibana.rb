kibana_service 'default' do
  action [:create]
end

kibana_config 'default' do
  port 8080
  action :create
  notifies :restart, 'kibana_service[default]'
end
