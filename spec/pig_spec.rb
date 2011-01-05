require 'spec_helper'

describe Pig do

  let(:style) { :plain }
  let(:pig) { Pig.new({:style => style}) }

  describe "#call" do

    before do
      pig.stub(:history).and_return('some text')
    end

    it "returns a valid rack response" do
      pig.call(:any_environment).should == [200, {"Content-Type" => "text/plain"}, ['some text']]
    end

  end

  describe "#format" do
    let(:commit_message) { stub(:to_s => "One great commit") }
    let(:author) { stub(:date => date, :name => "Dev Author") }
    let(:date) { stub(:strftime => "12-31-01") }
    let(:commit) { stub(:author => author, :to_s => "393932", :message => commit_message) }

    context "plain style" do
      let(:style) { :plain }
      it "returns the commit message, sha1, date, and author in plain text" do
        pig.send(:format, commit).should == "One great commit\n  393932\n  12-31-01 Dev Author\n\n"
      end
    end

    context "html style" do
      let(:style) { :html }
      it "returns the commit message, sha1, date, and author in html format" do
        pig.send(:format, commit).should == "<li><h3>One great commit</h3><br />393932<br />12-31-01 Dev Author<br /><br /></li>"
      end
    end

  end

  describe "#repository" do

    it "calls Git.open on the specified working directory" do
      Git.should_receive(:open, WORKING_DIR)
      pig.send(:repository)
    end

  end

  describe "#history" do

    it "retrieves a log of the last 10 commits by default" do
      repo = stub(:log)
      pig.should_receive(:repository).and_return(repo)
      repo.should_receive(:log, 10).and_return([])
      pig.history
    end

    context "when no commits" do
      before do
        repo = stub(:log)
        pig.stub(:repository).and_return(repo)
        repo.stub(:log, 10).and_return([])
      end

      context "plain style" do
        it "returns an empty string" do
          pig.history.should == ""
        end
      end

      context "html style" do
        let(:style) { :html }
        it "returns empty html" do
          pig.history.should == "<html><head><title>Deployed Revisions</title></head><body><ul></ul></body></html>"
        end
      end
    end
  end

end
