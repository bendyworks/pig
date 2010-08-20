require 'rails/generators'

class PigGenerator < Rails::Generators::Base

  class_option :skip_routes,
    :type => :boolean,
    :default => false,
    :desc => "Do not generate routes."

  def install_pig
    if options[:skip_routes]
      puts "Nothing to do"
    end
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

end
