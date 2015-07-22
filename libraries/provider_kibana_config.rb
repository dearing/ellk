class Chef
  class Provider
    class KibanaConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :kibana_config

      action :create do
        template '/etc/kibana.yml' do
          source 'kibana/kibana.yml.erb'
          owner new_resource.user
          owner new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
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
          }
        end
      end
    end
  end
end
