class Chef
  class Provider
    class Elasticsearch < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      provides :elasticsearch if Chef::Provider.respond_to?(:provides)
      service_name = 'elasticsearch'

      action :install do
        home_dir = "#{new_resource.path}/elasticsearch-#{new_resource.version}"

        user new_resource.user do
          system true
          shell '/sbin/nologin'
        end
        group new_resource.group do
          system true
        end

        ark service_name do
          checksum new_resource.checksum
          group new_resource.group
          has_binaries new_resource.has_binaries
          owner new_resource.user
          prefix_root new_resource.path
          url new_resource.url
          version new_resource.version
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        template "#{home_dir}/config/logging.yml" do
          source 'elasticsearch/logging.yml.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'datadir' => new_resource.datadir
          }.merge(new_resource.conf_options)
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        template "#{home_dir}/config/elasticsearch.yml" do
          source 'elasticsearch/elasticsearch.yml.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'datadir' => new_resource.datadir
          }.merge(new_resource.conf_options)
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        env_defaults = {
          'CONF_DIR' => nil,
          'CONF_FILE' => nil,
          'DATA_DIR' => new_resource.datadir,
          'ES_DIRECT_SIZE' => nil,
          'ES_GC_LOG_FILE' => '/var/log/elasticsearch/gc.log',
          'ES_GROUP' => new_resource.group,
          'ES_HEAP_NEWSIZE' => '',
          'ES_HEAP_SIZE' => '2g',
          'ES_HOME' => home_dir,
          'ES_JAVA_OPTS' => '',
          'ES_RESTART_ON_UPGRADE' => 'true',
          'ES_USER' => new_resource.user,
          'LOG_DIR' => nil,
          'MAX_LOCKED_MEMORY' => 'unlimited',
          'MAX_MAP_COUNT' => '262144',
          'MAX_OPEN_FILES' => '65535',
          'PID_DIR' => nil,
          'WORK_DIR' => nil
        }

        # TODO: signal for changes
        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          env env_defaults.merge(new_resource.runit_env)
          options new_resource.runit_options.merge(
            'home_dir' => home_dir,
            'user' => new_resource.user,
            'group' => new_resource.group
          )
          action [:create, :enable]
        end
      end

      action :remove do
        service service_name do
          action :stop
        end
      end

      ## SERVICES

      action :enable do
        service service_name do
          action :enable
        end
      end

      action :disable do
        service service_name do
          action :disable
        end
      end

      action :start do
        service service_name do
          action :start
        end
      end

      action :stop do
        service service_name do
          action :stop
        end
      end

      action :restart do
        service service_name do
          action :restart
        end
      end
    end
  end
end
