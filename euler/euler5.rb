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
min_pos = -1

while work_array[0].to_s*20 != work_array.join
  min_pos = work_array.index(work_array.min)
  work_array[min_pos] = work_array[min_pos] + base_array[min_pos]
end

puts work_array[0]
