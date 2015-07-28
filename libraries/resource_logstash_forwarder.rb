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

      # CONFIGURATION; HASH IT UP
      attribute :crt, kind_of: String, default: ''
      attribute :crt_location, kind_of: String, default: '/etc/logstash-forwarder/logstash.crt'
      attribute :key, kind_of: String, default: ''
      attribute :key_location, kind_of: String, default: '/etc/logstash-forwarder/logstash.key'
      attribute :chdir, kind_of: String, default: '/var/lib/logstash-forwarder'
      attribute :chroot, kind_of: String, default: '/'
      attribute :nice, kind_of: String, default: ''
      attribute :port, kind_of: Integer, default: 5043

      # RUNIT
      attribute :runit_args, kind_of: Hash, default: {}
      attribute :runit_options, kind_of: Hash, default: {}
      attribute :runit_env, kind_of: Hash, default: {}
    end
  end
end
