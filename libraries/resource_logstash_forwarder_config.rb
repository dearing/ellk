require 'chef/resource'

class Chef
  class Resource
    class LogstashForwarder < Chef::Resource::LWRPBase
      resource_name :logstash_forwarder_config
      default_action :create
      actions [:create, :delete]
    end
  end
end
