class Chef
  class Provider
    class LogstashForwarder < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      # provides :logstash_forwarder

      service_name = 'logstash-forwarder'

      action :install do
        # TODO: make home folder working dir
        user new_resource.user do 
          system true
          shell '/sbin/nologin'
        end
        group new_resource.group do
          system true
        end

        home_dir = "/opt/logstash-forwarder/logstash-forwarder-#{new_resource.version}"

        # TODO: sloppy
        directory home_dir do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true
          action :create
        end

        # TODO: react to os/arch
        remote_file "#{home_dir}/logstash-forwarder" do
          owner new_resource.user
          group new_resource.group
          mode '0755'
          source 'https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64'
          checksum '5f49c5be671fff981b5ad1f8c5557a7e9973b24e8c73dbf0648326d400e6a4a1'
        end

        template "#{home_dir}/logstash-forwarder.conf" do
          source 'logstash-forwarder/logstash-forwarder.conf.erb'
          owner new_resource.user
          group new_resource.group
          mode '0644'
          cookbook new_resource.source
          variables options: {
            'crt_location' => new_resource.crt_location,
            'key_location' => new_resource.key_location
          }
        end

        runit_service service_name do
          default_logger true
          owner new_resource.user
          group new_resource.group
          cookbook new_resource.source
          options new_resource.runit_options.merge(
            'home_dir' => home_dir,
            'user' => new_resource.user,
            'group' => new_resource.group,
            'config_file' => 'logstash-forwarder.conf'
          )
          action [:create, :enable]
        end
      end

      action :remove do
        runit_service service_name do
          action :stop
        end
      end

      ## SERVICE

      action :enable do
        service service_name do
          action :enable
        end
      end

      action :disable do
        service service_name do
          action :disable
        end
      end

      action :restart do
        service service_name do
          action :restart
        end
      end

      action :start do
        service service_name do
          action :start
        end
      end

      action :stop do
        service service_name do
          action :stop
        end
      end
    end
  end
end
