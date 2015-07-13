require 'chef/resource'

class Chef
  class Resource
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
