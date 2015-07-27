# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'kibana' do
  describe command('sv status kibana') do
    its(:stdout) { should match 'run: kibana' }
  end
end
