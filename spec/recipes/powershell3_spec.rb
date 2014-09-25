require 'spec_helper'
require 'chef/win32/version'

describe 'powershell::powershell3' do
  let(:chef_run) do 
    ChefSpec::Runner.new(platform: 'windows', version: '2012') do |node|
        node.set['powershell']['powershell3']['url'] = "https://powershelltest.com"
        node.set['powershell']['powershell3']['checksum'] = "12345"
      end.converge(described_recipe)
  end

  # To do
  # context "when windows_version is windows_server_2008" do
  #   before do
  #     @windows_version = double(:windows_server_2008? => true, :windows_server_2008_r2? => false, :windows_7? => false)
  #     allow(Chef::ReservedNames::Win32::Version).to receive(:new).and_return(@windows_version)
  #   end

  #   it "installs windows package windows managemet framework bits and windows management framework core 3.0" do
  #     #expect(chef_run).to receive(:include_recipe).with('powershell::powershell2')
  #     #Chef::Recipe.any_instance.stub(:include_recipe).with('powershell::powershell2').and_return(true)
  #     allow(chef_run).to receive(:include_recipe).with('powershell::powershell2').and_return(true)

  #     #expect(chef_run).to install_windows_package('Windows Management Framework Core').with(source: "https://powershelltest.com", checksum: "12345", installer_type: :custom, options: '/quiet/norestart')
  #     Chef::Recipe.any_instance.stub(:include_recipe).with('powershell::powershell2').and_return(true)
  #     #expect(chef_run).to include_recipe('ms_dotnet4')
  #     #expect(chef_run).to install_windows_package('Windows Management Framework Core').with(source: "https://powershelltest.com", checksum: "12345", installer_type: :custom, options: '/quiet/norestart')
  #   end
  # end

  context "when windows_version is windows_server_2008_r2" do
    before do
      @windows_version = double(:windows_server_2008? => false, :windows_server_2008_r2? => true, :windows_7? => false)
      allow(Chef::ReservedNames::Win32::Version).to receive(:new).and_return(@windows_version)
    end

    it "installs windows package windows management framework core 3.0" do
      expect(chef_run).to include_recipe('ms_dotnet4')
      # To do
      #expect(chef_run).to install_windows_package('Windows Management Framework Core').with(source: "https://powershelltest.com", checksum: "12345", installer_type: :custom, options: '/quiet/norestart')
    end
  end  

  context "when windows_version is windows_7" do
    before do
      @windows_version = double(:windows_server_2008? => false, :windows_server_2008_r2? => false, :windows_7? => true)
      allow(Chef::ReservedNames::Win32::Version).to receive(:new).and_return(@windows_version)
    end

    it "installs windows package windows management framework core 3.0" do
      expect(chef_run).to include_recipe('ms_dotnet4')
      # To do
      #expect(chef_run).to install_windows_package('Windows Management Framework Core').with(source: "https://powershelltest.com", checksum: "12345", installer_type: :custom, options: '/quiet/norestart')
    end
  end  
end