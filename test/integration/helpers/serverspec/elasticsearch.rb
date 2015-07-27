# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'elasticsearch' do
  	describe command('sv status elasticsearch') do
  		its(:stdout) { should match /run: elasticsearch/ }
	end
end

# curl -X GET http://localhost:9200/
# curl 'localhost:9200/_cat/health?v'
