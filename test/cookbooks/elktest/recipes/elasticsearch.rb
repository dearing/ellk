elasticsearch 'default'

elasticsearch_config 'default' do
  action :create
  notifies :start, 'elasticsearch[default]'
end
