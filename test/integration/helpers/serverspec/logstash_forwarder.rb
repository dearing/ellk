# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'logstash_forwarder' do
  describe command('sv status logstash-forwarder') do
    its(:stdout) { should match 'run: logstash-forwarder' }
  end
end
