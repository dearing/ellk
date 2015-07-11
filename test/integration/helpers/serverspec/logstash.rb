# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'logstash' do
  describe service('logstash') do
    it 'is enabled and running' do
      expect(subject).to be_enabled
      expect(subject).to be_running
    end
  end
end
