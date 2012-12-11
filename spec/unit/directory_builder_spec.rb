require 'kura'
require 'kura/directory_builder'
 
describe 'directory_builder' do 
  it "should identify all the files on a directory and list them (not other dirs)" do
    directory_files = Dir.new("spec/sample_dir").select { |file| file =~ /.src.rpm/ }
    output = fake_stdout { DirectoryBuilder.new("spec/sample_dir") }
    output.should =~ /#{directory_files.join("\n")}/
  end

  it "should instantiate a PackageBuilder for each package" do
    packages = Dir.new("spec/sample_dir").select { |file| file =~ /.src.rpm/ }
    fake_stdout do 
      dir_builder = DirectoryBuilder.new("spec/sample_dir") 
      packages.each do |package| 
        PackageBuilder.should_receive(:new).with(package)  
      end
      dir_builder.build
    end
  end
end
