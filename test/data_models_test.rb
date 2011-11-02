require 'test/unit'
require 'easy_data'

require 'ruby-debug'

class DataModelsTest < Test::Unit::TestCase

  def test_example
    debugger
    assert_equal Array,DataModels.load_models.class
  end
end 
