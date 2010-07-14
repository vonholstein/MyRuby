# Find the 10001st prime
# Write a generator that yields primes

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

# PrimeGenerator.new.each_with_index do |x,i|
#   if i == 10000
#     puts x
#     break
#   end  
# end

prime_sum = 0
PrimeGenerator.new.each do |x|
  if x < 2000000
    prime_sum = prime_sum + x
  else
    break
  end
end

puts prime_sum
