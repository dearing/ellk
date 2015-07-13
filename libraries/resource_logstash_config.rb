require 'chef/resource'

class Chef
  class Resource
    class LogstashConfig < Chef::Resource::LWRPBase
      resource_name :logstash_config
      default_action :create
      actions [:create, :delete]

      attribute :crt, kind_of: String, default: ''
      attribute :crt_location, kind_of: String, default: '/opt/logstash/logstash.crt'
      attribute :javacmd, kind_of: String, default: '/usr/bin/java'
      attribute :key, kind_of: String, default: ''
      attribute :key_location, kind_of: String, default: '/opt/logstash/logstash.key'
      attribute :ls_conf_dir, kind_of: String, default: '/etc/logstash/conf.d'
      attribute :ls_group, kind_of: String, default: 'logstash'
      attribute :ls_heap_size, kind_of: String, default: '500m'
      attribute :ls_home, kind_of: String, default: '/var/lib/logstash'
      attribute :ls_java_opts, kind_of: String, default: '-Djava.io.tmpdir=$HOME'
      attribute :ls_log_file, kind_of: String, default: '/var/log/logstash/logstash.log'
      attribute :ls_nice, kind_of: Integer, default: 19
      attribute :ls_open_files, kind_of: Integer, default: 16_384
      attribute :ls_opts, kind_of: String, default: ''
      attribute :ls_pidfile, kind_of: String, default: '/var/run/logstash.pid'
      attribute :ls_use_gc_logging, kind_of: [TrueClass, FalseClass], default: true
      attribute :ls_user, kind_of: String, default: 'logstash'
      attribute :port, kind_of: Integer, default: 5043
      attribute :source, kind_of: String, default: 'elk'
    end
  end
end
