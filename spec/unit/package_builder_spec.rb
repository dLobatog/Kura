require 'kura'
require 'kura/package_builder'

describe 'package_builder' do
  context "file name should contain version" do
    it "should not accept the file if the filename is wrong" do
      wrong_name = "noversions.src.rpm"
      InputFaker.with_fake_input(["owner","tag1 tag2"]) do
        output = fake_stdout { PackageBuilder.new(wrong_name).build } 
        output.should =~ /No specified version/
        # should exit? and not break previous test
      end
    end  
  end

  context "single package build" do
    it "should call system to add packages" do
      InputFaker.with_fake_input(["owner","tag1 tag2"]) do
        fake_stdout do
          pkg_builder = PackageBuilder.new("package-0.0.0-0.src.rpm")
          6.times { pkg_builder.should_receive(:system) } 
          pkg_builder.build
        end
      end
    end
  end

  context "it should find out what to build (dir or file)" do
    it "should call a single pkg build if its a file" do
      InputFaker.with_fake_input(["owner","tag1 tag2"]) do
        fake_stdout do
          pkg_builder = PackageBuilder.new("package-0.0.0-0.src.rpm")
          pkg_builder.should_receive(:start_build) 
          pkg_builder.build
        end
      end   
    end
  end
end
