# Write a generator that yields primes
# dd

require 'set'

class PrimeGenerator
  include Enumerable
  def each
    current_candidate = 1
    loop do
      current_candidate += 1
      flag = false
      (2..Math.sqrt(current_candidate).to_i).each do |k|
        if current_candidate%k == 0
          flag = true
          break
        end        
      end
      yield current_candidate if !flag      
    end    
  end  
end

prime_numbers = Set.new

PrimeGenerator.new.each do |x|
  if x < 1000000
    prime_numbers << x
  else
    break
  end
end

#find the minimum number of integers that tips over 1000000
prime_sum = 0
max_count = 0
prime_numbers.each_with_index do |x,i|
  prime_sum += x
  if prime_sum > 1000000
    max_count = i
    break
  end  
end

puts "Count = #{prime_numbers.count}"
max_count.downto(1).each do |j|
  puts "Iteration #{j}"
  prime_numbers.each_cons(j) do |k|
    current_prime_sum = k.reduce(:+)
    break if current_prime_sum > 1000000
    if prime_numbers.include? current_prime_sum
      puts current_prime_sum
      exit
    end    
  end  
end


