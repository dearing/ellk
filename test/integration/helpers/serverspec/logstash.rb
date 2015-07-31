# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'logstash' do
  describe command('sv status logstash') do
    its(:stdout) { should match 'run: logstash' }
  end
  describe file('/etc/service/logstash/env/LS_USER') do
  	it { should be_file }
  	its(:content) { should match 'logstash' }
  end
end
