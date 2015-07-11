elasticsearch_service 'default' do
  action [:create, :start, :enable, :restart, :stop, :delete]
end