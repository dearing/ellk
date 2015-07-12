require 'chef/resource'

class Chef
  class Resource
    class LogstashConfig < Chef::Resource::LWRPBase
      resource_name :logstash_config
      default_action :create
      actions [:create, :delete]

      attribute :source, kind_of: String, default: 'elk'

      attribute :javacmd, kind_of: String, default: '/usr/bin/java'
      attribute :ls_home, kind_of: String, default: '/var/lib/logstash'
      attribute :ls_opts, kind_of: String, default: ''
      attribute :ls_heap_size, kind_of: String, default: '500m'
      attribute :ls_java_opts, kind_of: String, default: '-Djava.io.tmpdir=$HOME'
      attribute :ls_pidfile, kind_of: String, default: '/var/run/logstash.pid'
      attribute :ls_user, kind_of: String, default: 'logstash'
      attribute :ls_group, kind_of: String, default: 'logstash'
      attribute :ls_log_file, kind_of: String, default: '/var/log/logstash/logstash.log'
      attribute :ls_use_gc_logging, kind_of: [TrueClass, FalseClass], default: true
      attribute :ls_conf_dir, kind_of: String, default: '/etc/logstash/conf.d'
      attribute :ls_open_files, kind_of: Integer, default: 16_384
      attribute :ls_nice, kind_of: Integer, default: 19
    end
  end
end