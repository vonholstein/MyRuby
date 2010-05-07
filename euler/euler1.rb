sum = 0
(1..999).to_a.each do |x|
  sum = (sum + x) if x % 3 == 0 || x % 5 == 0
end
sum_2 = (1..999).to_a.select { |x| x % 3 == 0 || x % 5 ==0 }.length
puts "Sum = #{sum}"
puts "Sum2 lenght = #{sum_2}"
