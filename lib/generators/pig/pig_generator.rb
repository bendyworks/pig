require 'rails/generators'

class PigGenerator < Rails::Generators::Base

  class_option :revision_path,
    :banner => '/path_to_revisions',
    :default => '/revision',
    :desc => 'A root-relative path at which to display revision information.'

  class_option :skip_routes,
    :type => :boolean,
    :default => false,
    :desc => "Do not generate routes."

  def install_pig
    if options[:skip_routes]
      puts "Nothing to do"
    else
      route("match '#{formatted_revision_path}', :to => Pig.new")
    end
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  protected

  def formatted_revision_path
    path = options[:revision_path]
    path.starts_with?('/') ? path : "/#{path}"
  end

end
