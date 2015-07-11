require 'chef/resource'

class Chef
  class Resource
    class KibanaConfig < Chef::Resource::LWRPBase
      resource_name :kibana_config
      default_action :create
      actions [:create, :delete]
    end
  end
end
