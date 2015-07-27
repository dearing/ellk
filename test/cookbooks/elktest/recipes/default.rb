
# test a single node with all four projects

%w( tar nano htop java-1.8.0-openjdk-headless).each do |pkg|
  package pkg
end

include_recipe 'runit::default'
include_recipe 'elktest::elasticsearch'
# include_recipe 'elktest::logstash'
# include_recipe 'elktest::logstash_forwarder'
include_recipe 'elktest::kibana'
