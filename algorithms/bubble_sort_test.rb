$: << '.'

# tests for bubble sort

require 'test/unit'
require 'test/unit/ui/console/testrunner'
load '~/my-ruby/bubble_sort.rb'

class TC_MyBubbleSort < Test::Unit::TestCase

  def test_Pass
    test_numbers = [140, 230, 93, 187, 163, 289, 46, 179, 21, 122];
    assert(true,MyBubbleSort.sort(test_numbers).first==21)
    assert(true,MyBubbleSort.sort(test_numbers).last==289)    
  end

  def test_large_pass
    test_numbers = (0..10000).collect { Random.rand(10000) }
    test_numbers.unshift(0)
    test_numbers.push(10000)
    assert(true,MyBubbleSort.sort(test_numbers).first==0)
    assert(true,MyBubbleSort.sort(test_numbers).last==10000)
  end
  
end

start_time = Time.now

Test::Unit::UI::Console::TestRunner.run(TC_MyBubbleSort)

puts "Execution time = #{Time.now-start_time}"

    
    
