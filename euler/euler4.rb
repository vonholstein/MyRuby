# Problem Statement
# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91  99.
# Find the largest palindrome made from the product of two 3-digit numbers.

#Algorithm
# Start from the top and multiply downwards while checking for palingdrome

i,j = 999,999
fin_array = []

while i > 1 do
  while j > 1 do
    if (i*j).to_s == (i*j).to_s.reverse
      #puts "#{i}*#{j}=#{i*j}"
      fin_array << i*j
    end
    j = j - 1
  end
  i = i - 1
  j = 999
end

fin_array.max

