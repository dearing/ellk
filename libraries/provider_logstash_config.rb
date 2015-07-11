class Chef
  class Provider
    class LogstashConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_config

      action :create do
      end

      action :delete do
      end
    end
  end
end
