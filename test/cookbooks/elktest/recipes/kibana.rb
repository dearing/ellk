kibana_service 'default' do
  action [:create, :enable]
end

kibana_config 'default' do
  action :create
  notifies :restart, 'kibana_service[default]'
end
