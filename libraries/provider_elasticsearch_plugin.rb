class Chef
  class Provider
    class ElasticsearchPlugin < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      provides :elasticsearch_plugin if Chef::Provider.respond_to?(:provides)

      action :install do
        home_dir = "#{new_resource.path}/elasticsearch-#{new_resource.version}"
        execute "install plugin #{new_resource.name}" do
          command "#{home_dir}/bin/plugin -install #{new_resource.name}"
        end
      end

      action :remove do
        home_dir = "#{new_resource.path}/elasticsearch-#{new_resource.version}"
        execute "install plugin #{new_resource.name}" do
          command "#{home_dir}/bin/plugin -remove #{new_resource.name}"
        end
      end
    end
  end
end
