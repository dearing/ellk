require 'chef/resource'

class Chef
  class Resource
    class ElasticsearchService < Chef::Resource::LWRPBase
      resource_name :elasticsearch_service
      default_action :create
      actions [:create, :delete, :enable, :disable, :restart, :start, :stop]
    end
  end
end
