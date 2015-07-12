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
      attribute :chdir, kind_of: String, default: '/var/lib/logstash-forwarder'
      attribute :nice, kind_of: String, default: ''

      attribute :port, kind_of: Integer, default: 5043
      attribute :key, kind_of: String, default: ''
      attribute :crt, kind_of: String, default: ''
      attribute :key_location, kind_of: String, default: '/opt/logstash-forwarder/logstash.key'
      attribute :crt_location, kind_of: String, default: '/opt/logstash-forwarder/logstash.crt'
    end
  end
end
