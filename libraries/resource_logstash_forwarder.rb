require 'chef/resource'

class Chef
  class Resource
    class LogstashForwarder < Chef::Resource::LWRPBase
      resource_name :logstash_forwarder
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # targeted cookbook for templates/files
      attribute :source, kind_of: String, default: 'ellk'

      # installation related
      attribute :group, kind_of: String, default: 'logstash'
      attribute :user, kind_of: String, default: 'logstash'
      attribute :url, kind_of: String, default: 'https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64'
      attribute :checksum, kind_of: String, default: '5f49c5be671fff981b5ad1f8c5557a7e9973b24e8c73dbf0648326d400e6a4a1'
      attribute :version, kind_of: String, default: '0.4.0'

      # configuration
      attribute :crt_location, kind_of: String, required: true, default: nil
      attribute :key_location, kind_of: String, required: false, default: nil
      attribute :port, kind_of: Integer, default: 5043
      attribute :timeout, kind_of: Integer, default: 15
      attribute :logstash_servers, kind_of: Array, default: ['localhost:5043']
      attribute :files, kind_of: Array, default: [{ 'paths' => ['/var/log/messages', '/var/log/*log'], 'fields' => { 'type' => 'syslog' } }]

      attribute :conf_options, kind_of: Hash, default: {}

      # runit usefulness
      attribute :runit_args, kind_of: Hash, default: {}
      attribute :runit_options, kind_of: Hash, default: {}
      attribute :runit_env, kind_of: Hash, default: {}
    end
  end
end
