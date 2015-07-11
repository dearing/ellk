class Chef
  class Provider
    class ElasticsearchConfig < Chef::Provider::LWRPBase
      include Elasticsearch::Helpers
      use_inline_resources if defined?(use_inline_resources)

      provides :elasticsearch_config

      action :create do
        template '/etc/sysconfig/elasticsearch' do
          source 'elasticsearch.sysconfig.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'es_user' => new_resource.es_user,
            'es_group' => new_resource.es_group,
            'es_home' => new_resource.es_home,
            'es_heap_size' => new_resource.es_heap_size,
            'es_heap_newsize' => new_resource.es_heap_newsize,
            'es_direct_size' => new_resource.es_direct_size,
            'max_open_files' => new_resource.max_open_files,
            'max_locked_memory' => new_resource.max_locked_memory,
            'max_map_count' => new_resource.max_map_count,
            'log_dir' => new_resource.log_dir,
            'data_dir' => new_resource.data_dir,
            'pid_dir' => new_resource.pid_dir,
            'work_dir' => new_resource.work_dir,
            'conf_dir' => new_resource.conf_dir,
            'conf_file' => new_resource.conf_file,
            'es_java_opts' => new_resource.es_java_opts,
            'restart_on_upgrade' => new_resource.restart_on_upgrade
          }
        end

        # TODO: probably better to let it source the sysconfig template instead
        template '/etc/init.d/elasticsearch' do
          source 'elasticsearch.initd.erb'
          owner 'root'
          group 'root'
          mode '0755'
          cookbook new_resource.source
          variables options: {
            'es_user' => new_resource.es_user,
            'es_group' => new_resource.es_group,
            'es_home' => new_resource.es_home,
            'es_heap_size' => new_resource.es_heap_size,
            'es_heap_newsize' => new_resource.es_heap_newsize,
            'es_direct_size' => new_resource.es_direct_size,
            'max_open_files' => new_resource.max_open_files,
            'max_locked_memory' => new_resource.max_locked_memory,
            'max_map_count' => new_resource.max_map_count,
            'log_dir' => new_resource.log_dir,
            'data_dir' => new_resource.data_dir,
            'pid_dir' => new_resource.pid_dir,
            'work_dir' => new_resource.work_dir,
            'conf_dir' => new_resource.conf_dir,
            'conf_file' => new_resource.conf_file,
            'es_java_opts' => new_resource.es_java_opts,
            'restart_on_upgrade' => new_resource.restart_on_upgrade
          }
        end
      end

      action :delete do
      end
    end
  end
end
