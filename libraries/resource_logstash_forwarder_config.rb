require 'chef/resource'

class Chef
  class Resource
    class LogstashForwarder < Chef::Resource::LWRPBase
      resource_name :logstash_forwarder_config
      default_action :create
      actions [:create, :delete]

      attribute :source, kind_of: String, default: 'elk'

      attribute :user, kind_of: String, default: 'root'
      attribute :group, kind_of: String, default: 'root'
      attribute :chroot, kind_of: String, default: '/'
      attribute :chdir, kind_of: String, default: 'var/lib/logstash-forwarder'
      attribute :nice, kind_of: String, default: ''
    end
  end
end
