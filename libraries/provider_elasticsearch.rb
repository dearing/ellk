class Chef
  class Provider
    class Elasticsearch < Chef::Provider::LWRPBase
      include ELK::Helpers
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
        end

        template "#{home_dir}/config/logging.yml" do
          source 'elasticsearch/logging.yml.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
        end

        template "#{home_dir}/config/elasticsearch.yml" do
          source 'elasticsearch/elasticsearch.yml.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
        end

        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          env new_resource.runit_env
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
