require 'git'

WORKING_DIR = File.join(File.dirname(File.expand_path(__FILE__)), "..")
NUMBER_OF_COMMITS = 10

class Pig

  def initialize options
    @style = options[:style]
  end

  def history
    results = ""
    commits = repository.log(NUMBER_OF_COMMITS) || []
    commits.each do |commit|
      results << format(commit)
    end
    @style == :html ? wrap(results) : results
  end

  def call env
    rack_response_template << [history]
  end

  def rack_response_template
    [200, {"Content-Type" => "text/#{@style}"}]
  end

  private

  def format commit
    case @style
    when :plain
      format_plain commit
    when :html
      format_html commit
    end
  end

  def repository
    Git.open root_dir
  end

  def root_dir
    if defined? Rails
      Rails.root
    else
      WORKING_DIR
    end
  end

  def wrap html_results
    "<html><head><title>Deployed Revisions</title></head><body><ul>#{html_results}</ul></body></html>"
  end

  def format_plain commit
    "#{commit.message}\n  #{commit.to_s}\n  #{commit.author.date.strftime("%Y-%m-%d")} #{commit.author.name}\n\n"
  end

  def format_html commit
    "<li><h3>#{commit.message}</h3><br />#{commit.to_s}<br />#{commit.author.date.strftime("%Y-%m-%d")} #{commit.author.name}<br /><br /></li>"
  end

end
