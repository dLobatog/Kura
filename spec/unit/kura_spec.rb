require 'spec_helper'
require 'kura'

describe 'kura' do
  context 'user interaction' do
    it 'should require at least one argument, directory or package' do
      failure_message = "What do you want to build? Examples:
                    one package: kura package.src.rpm
                  many packages: kura packages_dir/\n" 
      output = fake_stdout { Kura.new("") }
      output.should == failure_message
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
          kura = Kura.new(package)  
          DirectoryBuilder.should_not_receive(:new)
          PackageBuilder.should_receive(:new).with(package)
          kura.start_process
        end
      end
    end

    it "should use DirectoryBuilder for dirs" do
      InputFaker.with_fake_input(["owner", "tag"]) do 
        dir = "spec/sample_dir"
        fake_stdout do 
          kura = Kura.new(dir)  
          DirectoryBuilder.should_receive(:new).with(dir)
          PackageBuilder.should_not_receive(:new)
          kura.start_process
        end
      end                                   
    end
  end
end
