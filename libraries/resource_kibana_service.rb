require 'chef/resource'

class Chef
  class Resource
    class KibanaService < Chef::Resource::LWRPBase
      resource_name :kibana_service
      default_action :create
      actions [:create, :delete, :enable, :disable, :restart, :start, :stop]

      attribute :checksum, kind_of: String, default: '6f42d25f337fd49f38e2af81b9ab6e0c987a199a8c0b2e1410d072f812cb4520'
      attribute :group, kind_of: String, default: 'kibana'
      attribute :host, kind_of: String, default: '127.0.0.1'
      attribute :path, kind_of: String, default: '/opt/kibana'
      attribute :port, kind_of: [String, Integer], default: 3000
      attribute :url, kind_of: String, default: 'https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz'
      attribute :user, kind_of: String, default: 'kibana'
      attribute :version, kind_of: String, default: '4.1.1'

      attribute :source, kind_of: String, default: 'elk'
    end
  end
end
