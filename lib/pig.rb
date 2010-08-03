require 'git'

class Pig

  WORKING_DIR = File.join(File.dirname(File.expand_path(__FILE__)), "..")
  NUMBER_OF_COMMITS = 10

  def root_dir
    if defined? Rails
      Rails.root
    else
      WORKING_DIR
    end
  end

  def repository
    Git.open(root_dir)
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
    rack_response_template << [history]
  end

  def rack_response_template
    [200, {"Content-Type" => "text/plain"}]
  end
end
