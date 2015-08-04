packages = %w( tar nano htop )

case node[:platform_family]
when 'debian'
  include_recipe 'apt'
  packages << 'openjdk-7-jre-headless'
when 'rhel'
  include_recipe 'yum'
  if node[:platform_version].to_i == 5
    packages << 'java-1.7.0-openjdk'
  else
    packages << 'java-1.8.0-openjdk-headless'
  end
end

packages.each do |pkg|
  package pkg
end

include_recipe 'runit'
link '/usr/local/bin/sv' do
  to '/usr/bin/sv'
end

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

## ELASTICSEARCH                                                        
elasticsearch 'default' do
  datadir '/tmp/es_datadir'
  version '1.7.1'
  checksum '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019'
  url 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz'
end

## LOGSTASH
bonus_env = { 'HELLO' => 'WORLD', 'LS_USER' => 'kibana' } # for testing sake
bonus_conf = { 'test_value' => 'merged hash from a recipe!' }
logstash 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
  source 'ellktest'
  runit_env bonus_env
  conf_options bonus_conf
end

## LOGSTASH-FORWARDER
logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  # key_location '/tmp/logstash.key'
  logstash_servers ['localhost:5043']
  files [{ 'paths' => ['/var/log/messages', '/var/log/*log', '/var/log/kibana/current'], 'fields' => { 'type' => 'syslog' } }]
end

## KIBANA                               
kibana 'default' do
  port 8080
end
