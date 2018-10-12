require 'serverspec'

# Required by serverspec
set :backend, :exec


require 'spec_helper'

describe package('nginx'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('nginx'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(8082) do
  it { should be_listening }
end
