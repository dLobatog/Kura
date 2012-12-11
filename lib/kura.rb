class Kura
  attr_reader :input

  def initialize(input)
    @input = input
    failure_message = "What do you want to build? Examples:
                    one package: kura package.src.rpm
                  many packages: kura packages_dir/"  
    if @input.empty?
      puts failure_message 
      #exit
    else
      start_process
    end
  end

  def start_process
    @input = @input.to_s
    File.directory?(@input) ? DirectoryBuilder.new(@input) : PackageBuilder.new(@input)
  end

end
