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
      end

      action :delete do
        service 'kibana' do
          :stop
        end
      end

      action :restart do
        service 'kibana' do
          :restart
        end
      end

      action :start do
        service 'kibana' do
          :start
        end
      end

      action :stop do
        service 'kibana' do
          :stop
        end
      end
    end
  end
end
