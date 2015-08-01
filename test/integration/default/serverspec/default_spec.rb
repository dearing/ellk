require 'spec_helper'

describe 'ELLK stack' do
  include_examples 'elasticsearch'
  include_examples 'logstash'
  include_examples 'logstash_forwarder'
  include_examples 'kibana'
end
