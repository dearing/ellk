require 'chef/resource'

class Chef
  class Resource
    class LogstashForwarder < Chef::Resource::LWRPBase
      resource_name :logstash_forwarder
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'elk'

      attribute :group, kind_of: String, default: 'logstash'
      attribute :user, kind_of: String, default: 'logstash'
      attribute :version, kind_of: String, default: '0.4.0'
    end
  end
end
