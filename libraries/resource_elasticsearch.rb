require 'chef/resource'

class Chef
  class Resource
    class Elasticsearch < Chef::Resource::LWRPBase
      resource_name :elasticsearch
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'ellk'

      # ARK
      attribute :url, kind_of: String, default: 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz'
      attribute :checksum, kind_of: String, default: '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95'
      attribute :version, kind_of: String, default: '1.7.0'
      attribute :has_binaries, kind_of: Array, default: ['bin/elasticsearch']

      attribute :name, kind_of: String, default: 'elasticsearch'
      attribute :user, kind_of: String, default: 'elasticsearch'
      attribute :group, kind_of: String, default: 'elasticsearch'
      attribute :path, kind_of: String, default: '/opt/elasticsearch'

      attribute :datadir, kind_of: String, default: '/opt/esdatadir'
      attribute :conf_options, kind_of: Hash, default: {}

      # RUNIT
      attribute :runit_args, kind_of: Hash, default: {}
      attribute :runit_options, kind_of: Hash, default: {}
      attribute :runit_env, kind_of: Hash, default: {}
    end
  end
end
