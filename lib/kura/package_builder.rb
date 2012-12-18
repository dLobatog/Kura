class PackageBuilder
  attr_reader :package, :owner, :tags, :name

  def initialize(package, owner = "", tags = {})
    @package = File.basename(package)
    @name    = get_name
    if owner.empty?
      puts "Specify a package owner: "  
      @owner = $stdin.gets 
    else             
      @owner = owner
    end

    if tags.empty?
      puts "Specify tags: Separate them with spaces"
      @tags  = $stdin.gets.chomp.split
    else
      @tags = tags
    end
    start_build
  end

  def get_name
    if @package.split('-').length == 1
      puts "No specified version. 
            Package's name has to follow the format: name-0.0.0-0.src.rpm 
            where 0.0.0-0 is the version" 
      exit
    else 
      @package.split('-')[0..-3].join('-')
    end
  end

  def build
    start_build
  end

  private 
  def start_build
    puts "Building a single package #{@name}"
    add_package
    build_package
  end

  def add_package
    puts "#{@name} is being added to Koji"
    @tags.each do |tag|
      puts tag
      system("koji add-pkg --owner=#{@owner} #{tag} #{@name}")
    end
    puts "#{@name} is being added to Koji - FINISHED"
  end

  def build_package
    puts "Starting build of #{@package}" 
    @tags.each do |tag|
      system("koji build #{tag} #{@name}")
      system("koji tag-pkg #{tag} #{@package[0..-9]}") # remove extension *.src.rpm
    end 
    puts "Starting build of #{@package} - FINISHED " 
  end
end
