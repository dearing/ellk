class Chef
  class Provider
    class ElasticsearchConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :elasticsearch_config

      action :create do
        template '/etc/sysconfig/elasticsearch' do
          source 'elasticsearch/elasticsearch.sysconfig.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'conf_dir' => new_resource.conf_dir,
            'conf_file' => new_resource.conf_file,
            'data_dir' => new_resource.data_dir,
            'es_direct_size' => new_resource.es_direct_size,
            'es_group' => new_resource.es_group,
            'es_heap_newsize' => new_resource.es_heap_newsize,
            'es_heap_size' => new_resource.es_heap_size,
            'es_home' => new_resource.es_home,
            'es_java_opts' => new_resource.es_java_opts,
            'es_user' => new_resource.es_user,
            'log_dir' => new_resource.log_dir,
            'max_locked_memory' => new_resource.max_locked_memory,
            'max_map_count' => new_resource.max_map_count,
            'max_open_files' => new_resource.max_open_files,
            'pid_dir' => new_resource.pid_dir,
            'restart_on_upgrade' => new_resource.restart_on_upgrade,
            'work_dir' => new_resource.work_dir
          }
        end

        # TODO: probably better to let it source the sysconfig template instead
        template '/etc/init.d/elasticsearch' do
          source 'elasticsearch/elasticsearch.initd.erb'
          owner 'root'
          group 'root'
          mode '0755'
          cookbook new_resource.source
          variables options: {
            'conf_dir' => new_resource.conf_dir,
            'conf_file' => new_resource.conf_file,
            'data_dir' => new_resource.data_dir,
            'es_direct_size' => new_resource.es_direct_size,
            'es_group' => new_resource.es_group,
            'es_heap_newsize' => new_resource.es_heap_newsize,
            'es_heap_size' => new_resource.es_heap_size,
            'es_home' => new_resource.es_home,
            'es_java_opts' => new_resource.es_java_opts,
            'es_user' => new_resource.es_user,
            'log_dir' => new_resource.log_dir,
            'max_locked_memory' => new_resource.max_locked_memory,
            'max_map_count' => new_resource.max_map_count,
            'max_open_files' => new_resource.max_open_files,
            'pid_dir' => new_resource.pid_dir,
            'restart_on_upgrade' => new_resource.restart_on_upgrade,
            'work_dir' => new_resource.work_dir
          }
        end
      end

      action :delete do
        file '/etc/sysconfig/elasticsearc' do
          action :delete
        end

        file '/etc/init.d/elasticsearch' do
          action :delete
        end
      end
    end
  end
end
