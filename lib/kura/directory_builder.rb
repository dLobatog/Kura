require 'kura/package_builder'

class DirectoryBuilder
  attr_reader :directory, :packages

  def initialize(directory)
    @directory = directory                          
    @packages = Dir.new(@directory).select { |file| file =~ /.src.rpm/ } 
    puts "Packages in directory #{directory}: #{packages.join("\n")}"
  end

  def build
    @packages.each do |package|
      process_package(package)
    end
  end

  private
  def process_package(package)
    PackageBuilder.new(package)
  end
end
