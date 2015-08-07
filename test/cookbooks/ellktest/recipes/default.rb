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

# create certs (SN = localhost)
secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
file '/tmp/logstash.key' do
  content logstash_key
end
logstash_crt = Base64.decode64(secrets['certificate'])
file '/tmp/logstash.crt' do
  content logstash_crt
end

## install ELASTICSEARCH and configure to use tmp for data storage
elasticsearch 'default' do
  datadir '/tmp/es_datadir'
  version '1.7.1'
  checksum '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019'
  url 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz'
end

## install LOGSTASH and source my ellktest's templates instead
bonus_env = { 'HELLO' => 'WORLD', 'LS_USER' => 'kibana' } # for testing sake
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
  logstash_servers ['localhost:5043']
  files [
    {
      'paths' => ['/var/log/messages', '/var/log/*log'], 'fields' => { 'type' => "syslog-#{node.chef_environment}" }
    }
  ]
end

## install KIBANA and configure for port 8080, maybe we'll proxy to it from NGINX with some auth_basic?
kibana 'default' do
  port 8080
end
