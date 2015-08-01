class Chef
  class Provider
    class Kibana < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      provides :kibana if Chef::Provider.respond_to?(:provides)
      service_name = 'kibana'

      action :install do
        home_dir = "#{new_resource.path}/kibana-#{new_resource.version}"
        user new_resource.user do
          system true
          shell '/sbin/nologin'
        end
        group new_resource.group do
          system true
        end

        # ARK
        ark service_name do
          checksum new_resource.checksum
          group new_resource.group
          has_binaries ['bin/kibana']
          owner new_resource.user
          prefix_root new_resource.path
          url new_resource.url
          version new_resource.version
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        template "#{home_dir}/config/kibana.yml" do
          source 'kibana/kibana.yml.erb'
          owner new_resource.user
          owner new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'ca' => new_resource.ca,
            'default_app_id' => new_resource.default_app_id,
            'elasticsearch_preserve_host' => new_resource.elasticsearch_preserve_host,
            'elasticsearch_url' => new_resource.elasticsearch_url,
            'group' => new_resource.group,
            'host' => new_resource.host,
            'kibana_elasticsearch_client_crt' => new_resource.kibana_elasticsearch_client_crt,
            'kibana_elasticsearch_client_key' => new_resource.kibana_elasticsearch_client_key,
            'kibana_elasticsearch_password' => new_resource.kibana_elasticsearch_password,
            'kibana_elasticsearch_username' => new_resource.kibana_elasticsearch_username,
            'kibana_index' => new_resource.kibana_index,
            'log_file' => new_resource.log_file,
            'pid_file' => new_resource.pid_file,
            'ping_timeout' => new_resource.ping_timeout,
            'port' => new_resource.port,
            'request_timeout' => new_resource.request_timeout,
            'shard_timeout' => new_resource.shard_timeout,
            'ssl_cert_file' => new_resource.ssl_cert_file,
            'ssl_key_file' => new_resource.ssl_key_file,
            'startup_timeout' => new_resource.startup_timeout,
            'user' => new_resource.user,
            'verify_ssl' => new_resource.verify_ssl
          }.merge(new_resource.conf_options)
          notifies :restart, "runit_service[#{service_name}]", :delayed
        end

        # RUNIT
        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          env new_resource.runit_env
          options new_resource.runit_options.merge(
            'home_dir' => home_dir,
            'user' => new_resource.user,
            'group' => new_resource.group,
            'config_file' => "#{home_dir}/config/kibana.yml"
          )
          action [:create, :enable]
        end
      end

      action :remove do
        runit_service service_name do
          action :stop
        end
      end

      ## SERVICES
      action :enable do
        runit_service service_name do
          action :enable
        end
      end

      action :disable do
        runit_service service_name do
          action :disable
        end
      end

      action :start do
        runit_service service_name do
          action :start
        end
      end

      action :stop do
        runit_service service_name do
          action :stop
        end
      end

      action :restart do
        runit_service service_name do
          action :restart
        end
      end
    end
  end
end
