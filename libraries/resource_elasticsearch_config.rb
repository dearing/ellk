require 'chef/resource'

class Chef
  class Resource
    class ElasticsearchConfig < Chef::Resource::LWRPBase
      resource_name :elasticsearch_config
      default_action :create
      actions [:create, :delete]

      attribute :source, kind_of: String, default: 'elk'

      attribute :es_home, kind_of: String, default: '/usr/share/elasticsearch'
      attribute :es_user, kind_of: String, default: 'elasticsearch'
      attribute :es_group, kind_of: String, default: 'elasticsearch'
      attribute :es_heap_size, kind_of: String, default: '1g'
      attribute :es_heap_newsize, kind_of: String, default: nil
      attribute :es_direct_size, kind_of: String, default: nil
      attribute :max_open_files, kind_of: Integer, default: 65_535
      attribute :max_locked_memory, kind_of: String, default: 'unlimited'
      attribute :max_map_count, kind_of: Integer, default: 65_535
      attribute :pid_dir, kind_of: String, default: '/var/run/elasticsearch'
      attribute :log_dir, kind_of: String, default: '/var/log/elasticsearch'
      attribute :data_dir, kind_of: String, default: '/var/lib/elasticsearch'
      attribute :work_dir, kind_of: String, default: '/tmp/elasticsearch'
      attribute :conf_dir, kind_of: String, default: '/etc/elasticsearch'
      attribute :conf_file, kind_of: String, default: '/etc/elasticsearch/elasticsearch.yml'

      attribute :es_java_opts, kind_of: String, default: nil
      attribute :restart_on_upgrade, kind_of: [TrueClass, FalseClass], default: false

      # ES_USER 			The user to run as, defaults to elasticsearch
      # ES_GROUP 			The group to run as, defaults to elasticsearch
      # ES_HEAP_SIZE 		The heap size to start with
      # ES_HEAP_NEWSIZE 	The size of the new generation heap
      # ES_DIRECT_SIZE 		The maximum size of the direct memory
      # MAX_OPEN_FILES 		Maximum number of open files, defaults to 65535
      # MAX_LOCKED_MEMORY 	Maximum locked memory size. Set to "unlimited" if you use the bootstrap.mlockall option in elasticsearch.yml. You must also set ES_HEAP_SIZE.
      # MAX_MAP_COUNT 		Maximum number of memory map areas a process may have. If you use mmapfs as index store type, make sure this is set to a high value. For more information, check the linux kernel documentation about max_map_count. This is set via sysctl before starting elasticsearch. Defaults to 65535
      # LOG_DIR 			Log directory, defaults to /var/log/elasticsearch
      # DATA_DIR 			Data directory, defaults to /var/lib/elasticsearch
      # WORK_DIR 			Work directory, defaults to /tmp/elasticsearch
      # CONF_DIR 			Configuration file directory (which needs to include elasticsearch.yml and logging.yml files), defaults to /etc/elasticsearch
      # CONF_FILE 			Path to configuration file, defaults to /etc/elasticsearch/elasticsearch.yml
      # ES_JAVA_OPTS  		Any additional java options you may want to apply. This may be useful, if you need to set the node.name property, but do not want to change the elasticsearch.yml configuration file, because it is distributed via a provisioning system like puppet or chef. Example: ES_JAVA_OPTS="-Des.node.name=search-01"
      # RESTART_ON_UPGRADE 	Configure restart on package upgrade, defaults to false. This means you will have to restart your elasticsearch instance after installing a package manually. The reason for this is to ensure, that upgrades in a cluster do not result in a continuous shard reallocation resulting in high network traffic and reducing the response times of your cluster.
    end
  end
end
