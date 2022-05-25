# frozen_string_literal: true

control 'mongodb.config.file' do
  title 'Verify the configuration file'

  config_file = '/etc/mongod.conf'

  describe file(config_file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
  end

  describe yaml(config_file) do
    its(%w[storage dbPath]) { should eq '/var/lib/mongodb' }
  end
end
