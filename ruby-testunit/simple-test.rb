require 'test/unit'

class TC_MyTest < Test::Unit::TestCase

  def test_fail
    assert(false, 'Assertion was false')    
  end

  def test_pass
    assert(true, 'Assertion was false')    
  end

end

