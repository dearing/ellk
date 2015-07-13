class Chef
  class Provider
    class KibanaService < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :kibana_service

      action :create do
        user new_resource.user
        group new_resource.group

        ark 'kibana' do
          checksum new_resource.checksum
          group new_resource.group
          has_binaries ['bin/kibana']
          owner new_resource.user
          prefix_root new_resource.path
          url new_resource.url
          version new_resource.version
        end

        template '/etc/init.d/kibana' do
          cookbook new_resource.source
          source 'kibana/kibana.initd.erb'
          owner 'root'
          group 'root'
          mode '0755'
        end

      end

      action :delete do
        service 'kibana' do
          action :stop
        end
      end

      action :enable do
        service 'kibana' do
         action  :enable
        end
      end

      action :disable do
        service 'kibana' do
         action  :disable
        end
      end

      action :restart do
        service 'kibana' do
          action :restart
        end
      end

      action :start do
        service 'kibana' do
         action  :start
        end
      end

      action :stop do
        service 'kibana' do
          action :stop
        end
      end
    end
  end
end
