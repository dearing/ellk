require 'chef/resource'

class Chef
  class Resource
    class Logstash < Chef::Resource::LWRPBase
      resource_name :logstash
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'elk'

      # url and sha256 of the archive to download and unpack
      attribute :url, kind_of: String, default: 'https://download.elastic.co/logstash/logstash/logstash-1.5.3.tar.gz'
      attribute :checksum, kind_of: String, default: 'eb3c366074e561d777348bfe9db3d4d1cccbf2fa8e7406776f500b4ca639c4aa'

      # ARK tracks verioning by appending the :name with this for symlinking to a path
      attribute :version, kind_of: String, default: '1.5.3'
      attribute :has_binaries, kind_of: Array, default: ['bin/logstash']
      attribute :append_env_path, kind_of: [TrueClass, FalseClass], default: false

      # USER/GROUP to install by, also creates users on the OS for them
      attribute :user, kind_of: String, default: 'logstash'
      attribute :group, kind_of: String, default: 'logstash'
      attribute :owner, kind_of: String, default: 'logstash'

      attribute :path, kind_of: String, default: '/opt/logstash'
    end
  end
end
