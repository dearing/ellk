secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
logstash_crt = Base64.decode64(secrets['certificate'])

directory '/etc/logstash-forwarder' do
  mode '0755'
  action :create
  recursive true
end

file '/etc/logstash/logstash.key' do
  content logstash_key
end
file '/etc/logstash/logstash.crt' do
  content logstash_crt
end

logstash 'default'
