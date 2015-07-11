class Chef
  class Provider
    class KibanaConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :kibana_config

      action :create do
      end

      action :delete do
      end
    end
  end
end
