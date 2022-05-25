# frozen_string_literal: true

control 'mongodb.package.install' do
  title 'The required package should be installed'

  # Override by `platform_finger`
  package_name = 'mongodb-org-database'

  describe package(package_name) do
    it { should be_installed }
  end
end
