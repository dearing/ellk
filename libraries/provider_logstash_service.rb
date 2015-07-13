class Chef
  class Provider
    class LogstashService < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_service

      service_name = 'logstash'

      action :create do
        install_repository
        package service_name do
          action :install
        end
      end

      action :delete do
        service service_name do
          action :stop
        end
        package service_name do
         action  :remove
        end
        remove_repository
      end

      action :enable do
        service service_name do
         action  :enable
        end
      end

      action :restart do
        service service_name do
         action  :restart
        end
      end

      action :start do
        service service_name do
         action  :start
        end
      end

      action :stop do
        service service_name do
         action  :stop
        end
      end

      def install_repository
        yum_repository 'logstash-1.5' do
          description 'logstash repository for 1.5.x packages'
          baseurl 'http://packages.elasticsearch.org/logstash/1.5/centos'
          gpgkey 'https://packages.elastic.co/GPG-KEY-elasticsearch'
          action :create
        end
      end

      def remove_repository
        yum_repository 'logstash-1.5' do
          action :delete
        end
      end
    end
  end
end
