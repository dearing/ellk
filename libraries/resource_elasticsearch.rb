require 'chef/resource'

class Chef
  class Resource
    class Elasticsearch < Chef::Resource::LWRPBase
      resource_name :elasticsearch
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      require 'chef/resource'

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'elk'

      # url and sha256 of the archive to download and unpack
      attribute :url, kind_of: String, default: 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz'
      attribute :checksum, kind_of: String, default: '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95'

      # ARK tracks verioning by appending the :name with this for symlinking to a path
      attribute :version, kind_of: String, default: '1.7.0'
      attribute :has_binaries, kind_of: Array, default: ['bin/elasticsearch']
      attribute :append_env_path, kind_of: [TrueClass, FalseClass], default: false

      # USER/GROUP to install by, also creates users on the OS for them
      attribute :user, kind_of: String, default: 'elasticsearch'
      attribute :group, kind_of: String, default: 'elasticsearch'
      attribute :owner, kind_of: String, default: 'elasticsearch'

      attribute :path, kind_of: String, default: '/opt/elasticsearch'
      attribute :prefix_bin, kind_of: String, default: '/opt/bin'
    end
  end
end
