#Euler 6

sum_of_squares = (1..100).collect { |x| x**2 }.reduce(:+)
square_of_sums = (1..100).reduce(:+).**(2)

puts sum_of_squares - square_of_sums
