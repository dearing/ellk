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

    class ElasticsearchConfig < Chef::Resource::LWRPBase
      resource_name :elasticsearch_config
      default_action :create
      actions [:create, :delete]

      attribute :conf_dir, kind_of: String, default: '/etc/elasticsearch'
      attribute :conf_file, kind_of: String, default: '/etc/elasticsearch/elasticsearch.yml'
      attribute :data_dir, kind_of: String, default: '/var/lib/elasticsearch'
      attribute :es_direct_size, kind_of: String, default: nil
      attribute :es_group, kind_of: String, default: 'elasticsearch'
      attribute :es_heap_newsize, kind_of: String, default: nil
      attribute :es_heap_size, kind_of: String, default: '1g'
      attribute :es_home, kind_of: String, default: '/usr/share/elasticsearch'
      attribute :es_java_opts, kind_of: String, default: nil
      attribute :es_user, kind_of: String, default: 'elasticsearch'
      attribute :log_dir, kind_of: String, default: '/var/log/elasticsearch'
      attribute :max_locked_memory, kind_of: String, default: 'unlimited'
      attribute :max_map_count, kind_of: Integer, default: 65_535
      attribute :max_open_files, kind_of: Integer, default: 65_535
      attribute :pid_dir, kind_of: String, default: '/var/run/elasticsearch'
      attribute :restart_on_upgrade, kind_of: [TrueClass, FalseClass], default: false
      attribute :source, kind_of: String, default: 'elk'
      attribute :work_dir, kind_of: String, default: '/tmp/elasticsearch'
    end
  end
end
