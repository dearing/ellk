source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'elktest', path: './test/cookbooks/elktest'
  # until https://github.com/hw-cookbooks/runit/issues/142
  cookbook 'runit', '~> 1.5.18'
  # cookbook 'runit', git: "https://github.com/hw-cookbooks/runit.git", ref: "dev"
end
