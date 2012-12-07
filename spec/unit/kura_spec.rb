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
  end
end
