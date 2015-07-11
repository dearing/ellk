class Chef
  class Provider
    class LogstashConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_config

      action :create do
        template '/etc/sysconfig/logstash' do
          source 'sysconfig/logstash.sysconfig.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'javacmd' => new_resource.javacmd,
            'ls_home' => new_resource.ls_home,
            'ls_opts' => new_resource.ls_opts,
            'ls_heap_size' => new_resource.ls_heap_size,
            'ls_java_opts' => new_resource.ls_java_opts,
            'ls_pidfile' => new_resource.ls_pidfile,
            'ls_user' => new_resource.ls_user,
            'ls_group' => new_resource.ls_group,
            'ls_log_file' => new_resource.ls_log_file,
            'ls_use_gc_logging' => new_resource.ls_use_gc_logging,
            'ls_conf_dir' => new_resource.ls_conf_dir,
            'ls_open_files' => new_resource.ls_open_files,
            'ls_nice' => new_resource.ls_nice
          }
        end
      end

      action :create do
        template '/etc/init.d/logstash' do
          source 'initd/logstash.initd.erb'
          owner 'root'
          group 'root'
          mode '0755'
          cookbook new_resource.source
          variables options: {
            'javacmd' => new_resource.javacmd,
            'ls_home' => new_resource.ls_home,
            'ls_opts' => new_resource.ls_opts,
            'ls_heap_size' => new_resource.ls_heap_size,
            'ls_java_opts' => new_resource.ls_java_opts,
            'ls_pidfile' => new_resource.ls_pidfile,
            'ls_user' => new_resource.ls_user,
            'ls_group' => new_resource.ls_group,
            'ls_log_file' => new_resource.ls_log_file,
            'ls_use_gc_logging' => new_resource.ls_use_gc_logging,
            'ls_conf_dir' => new_resource.ls_conf_dir,
            'ls_open_files' => new_resource.ls_open_files,
            'ls_nice' => new_resource.ls_nice
          }
        end
      end
      action :delete do
      end
    end
  end
end
