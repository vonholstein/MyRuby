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

prime_numbers = []

PrimeGenerator.new.each do |x|
  if x > 1000 and x < 10000
    prime_numbers << x
  end
  break if x > 10000
end

prime_hash = {}

prime_numbers.each do |p|
  key = p.to_s.split('').sort.join
  if prime_hash.has_key? key
    prime_hash[key] << p
  else
    prime_hash[key] = [p]
  end
end

prime_hash.each do |k,v|
  if v.count >=3
    (0..v.count-1).each do |i|
      (i+1..v.count-1).each do |j|
        (j+1..v.count-1).each do |k|
          if v[k] - v[j] == v[j] - v[i]
            puts v[i],v[j],v[k]
          end
        end
      end
    end
  end
end

          

