class Chef
  class Provider
    class LogstashForwarderConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_forwarder_config

      action :create do
        directory '/etc/logstash-forwarder' do
          mode '0755'
          action :create
          recursive true
        end

        directory '/etc/logstash-forwarder/config.d' do
          mode '0755'
          action :create
          recursive true
        end

        template '/etc/logstash-forwarder/logstash-forwarder.conf' do
          source 'logstash-forwarder/logstash-forwarder.conf.erb'
          owner 'logstash'
          group 'logstash'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'crt_location' => new_resource.crt_location,
            'key_location' => new_resource.key_location
          }
        end
      end

      action :delete do
      end
    end
  end
end
