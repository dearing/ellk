# sshd_service = os[:family] == 'redhat' ? 'sshd' : 'ssh'

shared_examples 'elasticsearch' do
  describe service('elasticsearch') do
    it 'is enabled and running' do
      expect(subject).to be_enabled
      expect(subject).to be_running
    end
  end
end

# curl -X GET http://localhost:9200/
