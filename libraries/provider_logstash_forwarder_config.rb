class Chef
  class Provider
    class LogstashForwarderConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_forwarder_config

      action :create do
        template '/etc/init.d/logstash-forwarder' do
          source 'initd/logstash-forwarder.initd.erb'
          owner 'root'
          group 'root'
          mode '0755'
          cookbook new_resource.source
          variables options: {
            'user' => new_resource.user,
            'group' => new_resource.group,
            'chroot' => new_resource.chroot,
            'chdir' => new_resource.chdir,
            'nice' => new_resource.nice
          }
        end

        template '/etc/default/logstash-forwarder' do
          source 'logstash-forwarder.erb'
          owner 'root'
          group 'root'
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'user' => new_resource.user,
            'group' => new_resource.group,
            'chroot' => new_resource.chroot,
            'chdir' => new_resource.chdir,
            'nice' => new_resource.nice
          }
        end
      end

      action :delete do
      end
    end
  end
end
