class Kura
  def initialize(*argv)
    @argv = argv
    failure_message = "What do you want to build? Examples:
                    one package: kura package.src.rpm
                  many packages: kura packages_dir/"  
    puts failure_message if @argv.empty?
  end

end
