class Chef
  class Provider
    class Kibana < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :kibana

      service_name = 'kibana'

      action :install do
        user new_resource.user
        group new_resource.group

        ark service_name do
          checksum new_resource.checksum
          group new_resource.group
          has_binaries ['bin/kibana']
          owner new_resource.user
          prefix_root new_resource.path
          url new_resource.url
          version new_resource.version
        end

        runit_service 'kibana' do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          action [:create, :enable]
        end
      end

      action :remove do
        runit_service service_name do
          action :stop
        end
      end

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

      action :restart do
        runit_service service_name do
          action :restart
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
    end
  end
end
