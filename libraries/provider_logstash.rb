class Chef
  class Provider
    class Logstash < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      provides :logstash if Chef::Provider.respond_to?(:provides)

      service_name = 'logstash'

      action :install do
        home_dir = "/opt/logstash/logstash-#{new_resource.version}"

        user new_resource.user do
          system true
          shell '/sbin/nologin'
        end
        group new_resource.group do
          system true
        end

        directory "#{home_dir}/config" do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true
          action :create
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
          source 'logstash/logging.yml.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: new_resource.conf_options
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        template "#{home_dir}/config/logstash.conf" do
          source 'logstash/logstash.conf.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'port' => new_resource.port,
            'key_location' => new_resource.key_location,
            'crt_location' => new_resource.crt_location
          }.merge(new_resource.conf_options)
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        env_defaults = {
          'JAVACMD' => '/usr/bin/java',
          'LS_HOME' => home_dir,
          'LS_OPTS' => nil,
          'LS_HEAP_SIZE' => '500m',
          'LS_JAVA_OPTS' => '-Djava.io.tmpdir=$HOME',
          'LS_PIDFILE' => nil,
          'LS_USER' => new_resource.user,
          'LS_GROUP' => new_resource.group,
          'LS_LOG_FILE' => nil,
          'LS_USE_GC_LOGGING' => nil,
          'LS_CONF_DIR' => nil,
          'LS_OPEN_FILES' => '16384',
          'LS_NICE' => '19'
        }

        # TODO: signal for changes
        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          env env_defaults.merge(new_resource.runit_env)
          options new_resource.conf_options.merge(
            'home_dir' => home_dir,
            'user' => new_resource.user,
            'group' => new_resource.group,
            'config_file' => 'config/logstash.conf'
          )
          action [:create, :enable]
        end
      end

      action :remove do
        runit_service service_name do
          action :stop
        end
      end
      ## SERVICE

      action :enable do
        service service_name do
          action :enable
        end
      end

      action :restart do
        service service_name do
          action :restart
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
    end
  end
end
