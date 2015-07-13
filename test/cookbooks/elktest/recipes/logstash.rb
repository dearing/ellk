logstash_service 'default' do
  action [:create, :start, :enable]
end

secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
logstash_crt = Base64.decode64(secrets['certificate'])

file '/opt/logstash/logstash.key' do
  content logstash_key
end
file '/opt/logstash/logstash.crt' do
  content logstash_crt
end

logstash_config 'default' do
  action :create
  key logstash_key
  crt logstash_crt
  notifies :restart, 'logstash_service[default]'
end
