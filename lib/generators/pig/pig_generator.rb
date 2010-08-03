require 'rails/generators'

class PigGenerator < Rails::Generators::Base

  def install_pig
    route("match '/revision', :to => Pig.new")
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

end
