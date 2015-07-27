# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'logstash' do
  describe command('sv status logstash') do
    its(:stdout) { should match 'run: logstash' }
  end
end
