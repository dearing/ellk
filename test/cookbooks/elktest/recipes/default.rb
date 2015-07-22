
# test a single node with all three projects

package 'htop'
package 'java-1.8.0-openjdk-headless'
package 'nginx'

include_recipe 'runit::default'

include_recipe 'elktest::elasticsearch'
include_recipe 'elktest::logstash'
include_recipe 'elktest::logstash_forwarder'
include_recipe 'elktest::kibana'
