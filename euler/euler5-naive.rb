#Problem Statement
#2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?

#Algorithm
# Implementing algorithm at http://www.cut-the-knot.org/Curriculum/Arithmetic/LCM.shtml
# 1. Have a base from 1 to 20
# 2. Increment the current smallest number by the base number in the same position
# 3. Repeat until all elements are equal(sumofarray/20=1stelem)

base_array = (1..20).to_a
work_array = (1..20).to_a
result_array = []

1.upto(19) do |k|
  flag = true
  until flag == false do
    flag = false
    i = work_array.min
    work_array.collect! do |j|
      if j%i == 0
        flag = true
        j/i
      else
        j
      end
    end
    puts "k=#{k} #{work_array.inspect}"
    result_array << i if flag == true
  end
end

          
      
      
      
