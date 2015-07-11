# Encoding: utf-8

require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:/bin:/usr/bin:$PATH'

require 'elasticsearch'
require 'logstash'
require 'logstash_forwarder'
require 'kibana'
