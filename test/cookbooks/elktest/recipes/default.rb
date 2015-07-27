# test a single node with all four projects
%w( tar nano htop java-1.8.0-openjdk-headless).each do |pkg|
  package pkg
end

include_recipe 'runit::default'

# create certs (subject = localhost)
secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
file '/tmp/logstash.key' do
  content logstash_key
end
logstash_crt = Base64.decode64(secrets['certificate'])
file '/tmp/logstash.crt' do
  content logstash_crt
end

elasticsearch 'default'

logstash 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
end

logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
end

kibana 'default'
