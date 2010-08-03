require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pig"
    gem.summary = %Q{A rack endpoint to view the latest commits in the running version.}
    gem.description = %Q{A rack endpoint to dynamically view the latest N formatted commits.  Pig takes its name from the classic story of the chicken and the pig.  Many versions of this idea exist as jokes or anecdotes wherein the two decide to start a restaurant named Ham-n-Eggs.  Ultimately, the pig chooses not to participate because he would be committed and the chicken merely involved.}
    gem.email = "bigtiger@hashrocket.com"
    gem.homepage = "http://github.com/bigtiger/pig"
    gem.authors = ["Jim Remsik"]
    gem.add_dependency "git", "= 1.2.5"
    gem.add_development_dependency "rspec", ">= 1.2.9"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
