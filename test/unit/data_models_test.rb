require 'test/unit'
require 'easy_data'

class DataModelsTest < Test::Unit::TestCase

  def test_load_models
     assert_equal 'Array', DataModels.load_models.class.to_s
  end

end
