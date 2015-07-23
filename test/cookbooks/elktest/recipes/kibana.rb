kibana 'default'

kibana_config 'default' do
  port 8080
  action :create
  notifies :restart, 'kibana[default]'
end
