require 'git'

class Pig

  WORKING_DIR = File.join(File.dirname(File.expand_path(__FILE__)), "..", "..")
  NUMBER_OF_COMMITS = 10

  def repository
    Git.open(WORKING_DIR)
  end

  def history
    results = ""
    commits = repository.log(NUMBER_OF_COMMITS) || []
    commits.each do |commit|
      results << format(commit)
    end
    results
  end

  def format(commit)
    "#{commit.to_s} #{commit.author.date.strftime("%Y-%m-%d")} #{commit.author.name}\n"
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [history]]
  end

end
