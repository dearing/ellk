require 'chef/resource'

class Chef
  class Resource
    class Elasticsearch < Chef::Resource::LWRPBase
      resource_name :elasticsearch
      default_action :install
      actions [:install, :remove, :enable, :disable, :restart, :start, :stop]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'elk'

      # ARK
      # url and sha256 of the archive to download and unpack
      attribute :url, kind_of: String, default: 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz'
      attribute :checksum, kind_of: String, default: '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95'
      attribute :version, kind_of: String, default: '1.7.0'
      attribute :has_binaries, kind_of: Array, default: ['bin/elasticsearch']
      # attribute :append_env_path, kind_of: [TrueClass, FalseClass], default: false

      attribute :name, kind_of: String, default: 'elasticsearch'
      attribute :user, kind_of: String, default: 'elasticsearch'
      attribute :group, kind_of: String, default: 'elasticsearch'
      attribute :owner, kind_of: String, default: 'elasticsearch'
      attribute :path, kind_of: String, default: '/opt/elasticsearch'

      # RUNIT
      attribute :runit_args, kind_of: Hash, default: {

      }

      attribute :runit_options, kind_of: Hash, default: {

      }
      attribute :runit_env, kind_of: Hash, default: {
        'CONF_DIR' => '/etc/elasticsearch',
        'CONF_FILE' => '$CONF_DIR/elasticsearch.yml',
        'DATA_DIR' => '/var/lib/elasticsearch',
        'ES_DIRECT_SIZE' => '',
        'ES_GC_LOG_FILE' => '/var/log/elasticsearch/gc.log',
        'ES_GROUP' => 'elasticsearch',
        'ES_HEAP_NEWSIZE' => '',
        'ES_HEAP_SIZE' => '2g',
        'ES_HOME' => '/usr/share/elasticsearch',
        'ES_JAVA_OPTS' => '',
        'ES_RESTART_ON_UPGRADE' => 'true',
        'ES_USER' => 'elasticsearch',
        'LOG_DIR' => '/var/log/elasticsearch',
        'MAX_LOCKED_MEMORY' => 'unlimited',
        'MAX_MAP_COUNT' => '262144',
        'MAX_OPEN_FILES' => '65535',
        'PID_DIR' => '/var/run/elasticsearch',
        'WORK_DIR' => '/tmp/elasticsearch'
      }
    end
  end
end
