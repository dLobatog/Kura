require 'kura/directory_builder'
require 'kura/package_builder'

class Kura
  attr_reader :input, :owner, :tags

  def initialize(input, owner = "", tags = {})
    @input    = input
    @owner    = owner
    @tags = tags
    failure_message = "What do you want to build? Examples:
                    one package: kura package.src.rpm
                  many packages: kura packages_dir/"  
    if @input.empty?
      puts failure_message 
      exit
    else
      start_process
    end
  end

  def start_process
    @input = @input.to_s
    File.directory?(@input) ? DirectoryBuilder.new(@input, @owner, @tags) 
                            : PackageBuilder.new(@input, @owner, @tags)
  end

end
