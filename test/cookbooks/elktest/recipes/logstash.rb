logstash_service 'default' do
  action [:create, :start, :enable]
end

logstash_config 'default' do
  action [:create]
end
