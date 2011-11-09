require 'test/unit'
require 'easy_data'

require 'ruby-debug'

class RDFaTest < Test::Unit::TestCase

   def setup
      @rdfa = RDFa.new
   end

   def test_a_tag
     
     link = @rdfa.a("User",'http://www.google.es','id','class="link"')
     assert_equal String,link.class
   end 

end
