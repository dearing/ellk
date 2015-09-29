require 'chef/resource'

class Chef
  class Resource
    class ElasticsearchPlugin < Chef::Resource::LWRPBase
      resource_name :elasticsearch_plugin
      default_action :install
      actions [:install, :remove]

      # used to target any files/templates; default to self
      attribute :source, kind_of: String, default: 'ellk'

      # Plugin
      attribute :name, kind_of: String
      attribute :path, kind_of: String, default: '/opt/elasticsearch'
    end
  end
end
