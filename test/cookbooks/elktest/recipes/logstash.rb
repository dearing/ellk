secrets = Chef::DataBagItem.load('secrets', 'logstash')
logstash_key = Base64.decode64(secrets['key'])
logstash_crt = Base64.decode64(secrets['certificate'])

file '/tmp/logstash.key' do
  content logstash_key
end
file '/tmp/logstash.crt' do
  content logstash_crt
end

logstash 'default'
