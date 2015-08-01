# test a single node with all four projects
%w( tar nano htop java-1.8.0-openjdk-headless ).each do |pkg|
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

elasticsearch 'default' do
  datadir '/tmp/es_datadir'
end

bonus_env = { 'HELLO' => 'WORLD', 'LS_USER' => 'kibana' } # for testing sake
# demonstrate sneaking in extra configuration when sourceing outside the ellk cookbook
bonus_conf = { 'test_value' => 'merged hash from a recipe!' }
logstash 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
  source 'ellktest'
  runit_env bonus_env
  conf_options bonus_conf
end

logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
  logstash_servers ['localhost:5043']
  files [{ 'paths' => ['/var/log/messages', '/var/log/*log', '/var/log/kibana/current'], 'fields' => { 'type' => 'syslog' } }]
end

kibana 'default' do
  port 8080
end
