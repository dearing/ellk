name 'ellk'
maintainer 'Jacob Dearing'
maintainer_email 'jacob.dearing@gmail.com'
license 'MIT'
description 'Library to handle Elasticsearch, Logstash, Logstash-Forwarder & Kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.6'

issues_url 'https://github.com/dearing/ellk/issues' if respond_to?(:issues_url)
source_url 'https://github.com/dearing/ellk' if respond_to?(:source_url)


%w(ubuntu debian centos redhat amazon scientific oracle enterpriseenterprise).each do |os|
  supports os
end

depends 'ark'
depends 'runit'
