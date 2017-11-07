# encoding: utf-8

control '01' do
  impact 1.0
  title 'Verify grafana '
  desc 'Ensures grafana service and web is up and running'

  describe service('grafana-server') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("grafana") do
    it { should exist }
  end
  describe group("grafana") do
    it { should exist }
  end

  describe port(3000) do
    it { should be_listening }
    its('processes') {should include 'grafana-server'}
  end
  describe http('http://127.0.0.1:3000/login') do
    its('status') { should cmp 200 }
  end

  describe file('/var/lib/grafana/plugins/grafana-clock-panel') do
    it { should exist }
   end

end