require 'chef/resource'

class Chef
  class Resource
    class LogstashForwarderService < Chef::Resource::LWRPBase
      resource_name :logstash_forwarder_service
      default_action :create
      actions [:create, :delete, :enable, :restart, :start, :stop]
    end
  end
end
