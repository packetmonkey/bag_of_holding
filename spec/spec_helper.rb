$LOAD_PATH << File.expand_path('../..', __FILE__)

require 'lib/bag_of_holding'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
