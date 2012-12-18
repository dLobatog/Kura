require 'spec_helper'
require 'kura'

describe 'kura' do
  context 'user interaction' do
    it 'should require at least one argument, directory or package' do
      lambda do
        fake_stdout { Kura.new("") }
      end.should raise_error SystemExit
    end

    it "should not print any error message with a proper argument" do
      InputFaker.with_fake_input(["owner", "tag"]) do 
        output = fake_stdout { Kura.new("package-0.0.0-1.src.rpm") }
        output.should_not =~ /What do you want to build/
      end
    end
  end

  context "files and directories" do
    it "should use PackageBuilder for files" do
      InputFaker.with_fake_input(["owner", "tag"]) do 
        package = "package-0.0.0-1.src.rpm"
        fake_stdout do 
          DirectoryBuilder.should_not_receive(:new)
          PackageBuilder.should_receive(:new).with(package, "", {})
          kura = Kura.new(package)  
        end
      end
    end

  end
end
