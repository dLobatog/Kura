require 'kura/package_builder'

class DirectoryBuilder
  attr_reader :directory, :packages, :owner, :tags

  def initialize(directory, owner = "", tags = {})
    @directory = directory                          
    @owner = owner
    @tags = tags
    @packages = Dir.new(@directory).select { |file| file =~ /.src.rpm/ } 
    puts "Packages in directory #{directory}:\n ---\n#{packages.join("\n")}"
    build
  end

  def build
    @packages.each do |package|
      process_package(package)
    end
  end

  private
  def process_package(package)
    PackageBuilder.new(package, @owner, @tags)
  end
end
