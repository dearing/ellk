# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'elasticsearch' do

  describe command('sv status elasticsearch') do
    its(:stdout) { should match 'run: elasticsearch' }
  end

  describe command('curl http://localhost:9200/') do
    its(:stdout) { should match '"status" : 200,' }
  end

  describe command('curl http://localhost:9200/_cat/health?v') do
    its(:stdout) { should match 'elasticsearch' }
  end

  describe file('/etc/service/elasticsearch/env/ES_USER') do
  	it { should be_file }
  	its(:content) { should match 'elasticsearch' }
  end
end
