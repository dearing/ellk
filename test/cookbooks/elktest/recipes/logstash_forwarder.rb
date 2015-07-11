logstash_forwarder_service 'default' do
  action [:create, :start]
end

logstash_forwarder_config 'default' do
  action [:create]
end
