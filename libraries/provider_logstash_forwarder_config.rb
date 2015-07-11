class Chef
  class Provider
    class LogstashForwarderConfig < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      provides :logstash_forwarder_config

      action :create do
      end

      action :delete do
      end
    end
  end
end
