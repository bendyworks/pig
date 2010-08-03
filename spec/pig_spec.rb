require 'spec_helper'

describe Pig do

  let(:pig) { Pig.new }

  describe "#call" do

    before do
      pig.stub(:history).and_return('some text')
    end

    it "returns a valid rack response" do
      pig.call(:any_environment).should == [200, {"Content-Type" => "text/plain"}, ['some text']]
    end

  end

  describe "#format" do

    let(:commit) { stub(:author => author, :to_s => "393932") }
    let(:author) { stub(:date => date, :name => "Dev Author") }
    let(:date) { stub(:strftime => "12-31-01") }

    it "returns the sha1, date, and author by default" do
      pig.format(commit).should == "393932 12-31-01 Dev Author\n"
    end

  end

  describe "#repository" do

    it "calls Git.open on the specified working directory" do
      Git.should_receive(:open, Pig::WORKING_DIR)
      pig.repository
    end

  end

  describe "#history" do

    before do
      repo = stub(:log)
      pig.stub(:repository).and_return(repo)
      repo.stub(:log, 10).and_return([])
    end

    it "retrieves a log of the last 10 commits by default" do
      repo = stub(:log)
      pig.should_receive(:repository).and_return(repo)
      repo.should_receive(:log, 10).and_return([])
      pig.history
    end

    it "returns an empty string if no commits are found" do
      pig.history.should == ""
    end

  end

end
