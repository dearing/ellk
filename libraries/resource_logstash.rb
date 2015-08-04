require 'chef/resource'

class Chef
  class Resource
    class Logstash < Chef::Resource::LWRPBase
      resource_name :logstash
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'ellk'

      # url and sha256 of the archive to download and unpack
      attribute :url, kind_of: String, default: 'https://download.elastic.co/logstash/logstash/logstash-1.5.3.tar.gz'
      attribute :checksum, kind_of: String, default: 'eb3c366074e561d777348bfe9db3d4d1cccbf2fa8e7406776f500b4ca639c4aa'
      attribute :version, kind_of: String, default: '1.5.3'
      attribute :has_binaries, kind_of: Array, default: ['bin/logstash']

      # USER/GROUP to install by, also creates users on the OS for them
      attribute :user, kind_of: String, default: 'logstash'
      attribute :group, kind_of: String, default: 'logstash'

      attribute :path, kind_of: String, default: '/opt/logstash'

      attribute :crt_location, kind_of: String, required: true, default: '/etc/logstash/logstash.crt'
      attribute :key_location, kind_of: String, required: true, default: '/etc/logstash/logstash.key'

      attribute :port, kind_of: Integer, default: 5043
      attribute :conf_options, kind_of: Hash, default: {}

      # RUNIT
      attribute :runit_args, kind_of: Hash, default: {}
      attribute :runit_options, kind_of: Hash, default: {}
      attribute :runit_env, kind_of: Hash, default: {}
    end
  end
end
