require 'spec_helper'
require 'kura'

describe 'kura' do
  context 'user interaction' do
    before(:each) { output_file = StringIO.new }

    it 'should require at least one argument, directory or package' do
      failure_message = "What do you want to build? Examples:
                    one package: kura package.src.rpm
                  many packages: kura packages_dir/\n" 
      output = capture_stdout { Kura.new }
      output.should == failure_message
    end

    it "should not print any error message with a proper argument" do
      output = capture_stdout { Kura.new("package.src.rpm") }
      output.should == ""
    end
  end
end
