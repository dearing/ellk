## ELLKTEST
## demonstrate and test ELLK's functionality

## https://xkcd.com/378/
packages = %w( tar nano htop )

## logstash and elasticsearch require java, let us install it then
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

# build up an array of logs to ship out
logs = []

# all of our tested linux flavors come with syslog, lets shove that in
logs << {
  'paths' => ['/var/log/messages', '/var/log/*log'],
  'fields' => {
    'type' => 'syslog',
    'chef_node' => node.name,
    'chef_env' => node.chef_environment
  }
}

# we stored an unencrypted certificate for localhost
# fetch it and store it on the system
secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
file '/tmp/logstash.key' do
  content logstash_key
end
logstash_crt = Base64.decode64(secrets['certificate'])
file '/tmp/logstash.crt' do
  content logstash_crt
end

# install ELASTICSEARCH 1.7.1 instead of the default of 1.7.0
# and configure to use tmp for data storage
elasticsearch 'default' do
  datadir '/tmp/es_datadir'
  version '1.7.1'
  checksum '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019'
  url 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz'
end
# We'll go ahead and ship elasticsearch logs, too
logs <<
  {
    'paths' => ['/var/log/elasticsearch/current'],
    'fields' => {
      'type' => 'eslasticsearch',
      'chef_node' => node.name,
      'chef_env' => node.chef_environment
    }
  }

## install LOGSTASH and source my ellktest's templates instead and demonstrate merging in execution vars
bonus_env = { 'HELLO' => 'WORLD', 'LS_USER' => 'kibana' } # for testing sake
bonus_conf = { 'test_value' => 'merged hash from a recipe!' }
logstash 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
  source 'ellktest'
  runit_env bonus_env
  conf_options bonus_conf
end

## install KIBANA and configure for port 8080, maybe we'll proxy to it from NGINX with some auth_basic?
kibana 'default' do
  port 8080
end

## We may want to visualize Kibana's logs and pretend it is in a prod environment
logs <<
  {
    'paths' => ['/var/log/kibana/current'],
    'fields' => {
      'type' => 'kibana',
      'chef_node' => node.name,
      'chef_env' => 'prod'
    }
  }

## Install the forwarder and configure it to ship everything in logs up to this point.
logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  logstash_servers ['localhost:5043']
  files logs
end
