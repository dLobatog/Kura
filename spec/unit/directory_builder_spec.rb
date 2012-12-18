require 'kura'
require 'kura/directory_builder'
 
describe 'directory_builder' do 
  it "should identify all the files on a directory and list them (not other dirs)" do
    directory_files = Dir.new("spec/sample_dir").select { |file| file =~ /.src.rpm/ }
    output = fake_stdout { PackageBuilder.should_receive(:new).exactly(directory_files.count)
                           DirectoryBuilder.new("spec/sample_dir") }
    output.should =~ /#{directory_files.join("\n")}/
  end

  it "should instantiate a PackageBuilder for each package" do
    packages = Dir.new("spec/sample_dir").select { |file| file =~ /.src.rpm/ }
    fake_stdout do 
      packages.each do |package| 
        PackageBuilder.should_receive(:new).with(package, "", {})  
      end
      dir_builder = DirectoryBuilder.new("spec/sample_dir") 
    end
  end
end
