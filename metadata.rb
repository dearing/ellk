name 'ellk'
maintainer 'Jacob Dearing'
maintainer_email 'jacob.dearing@gmail.com'
license 'MIT'
description 'Library to handle Elasticsearch, Logstash, Logstash-Forwarder & Kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.2'

%w(ubuntu debian centos redhat amazon scientific oracle enterpriseenterprise).each do |os|
  supports os
end

depends 'ark'
depends 'runit', '= 1.5.18' # until https://github.com/hw-cookbooks/runit/issues/142
