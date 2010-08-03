require 'rspec'
# optionally add autorun support
require 'rspec/autorun'
require 'pig'

Rspec.configure do |c|
  c.mock_with :rspec
end
