# require 'factory_girl_rails'


RSpec.configure do |config|
  
  config.expect_with :rspec do |expectations|
  # config.include FactoryGirl::Syntax::Methods
  expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  
  end

  # FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
  # FactoryGirl.find_definitions

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
