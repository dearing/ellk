require 'chef/resource'

class Chef
  class Resource
    class LogstashConfig < Chef::Resource::LWRPBase
      resource_name :logstash_config
      default_action :create
      actions [:create, :delete]
    end
  end
end
