#2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?


# Create array from 1 to 20
# factor array from 2 onwards upto 20, multiply what is left

number_array = (1..20).to_a
multiplier = 1

(2..20).each do |n|
  factor, factored = n, false
  while !factored
    # Divide each element in array by factor if divisible
    prev_number_array = number_array
    number_array = number_array.collect do |x| 
      if x%factor == 0
        x/factor
      else
        x
      end      
    end    
    if prev_number_array == number_array
      factored = true
    else
      multiplier = multiplier * factor
    end    
  end  
end

lcm = multiplier * number_array.reduce(:*)

puts lcm
