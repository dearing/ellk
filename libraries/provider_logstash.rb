class Chef
  class Provider
    class Logstash < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      # provides :logstash

      service_name = 'logstash'
      action :install do
        home_dir = "/opt/logstash/logstash-#{new_resource.version}"

        user new_resource.user
        group new_resource.group

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
        end

        template "#{home_dir}/config/logging.yml" do
          source 'logstash/logging.yml.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
        end

        template "#{home_dir}/config/logstash.conf" do
          source 'logstash/logstash.conf.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'port' => new_resource.port,
            'key' => new_resource.key,
            'crt' => new_resource.crt,
            'key_location' => new_resource.key_location,
            'crt_location' => new_resource.crt_location
          }
        end

        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.user
          cookbook new_resource.source
          env new_resource.runit_env
          options new_resource.runit_options.merge(
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
