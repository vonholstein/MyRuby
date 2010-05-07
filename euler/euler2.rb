#The prime factors of 13195 are 5, 7, 13 and 29.
#What is the largest prime factor of the number 600851475143 ?

# Sieve of erasthosthenes to generate a list of primes upto 200
def get_primes_eras (number)

  num_list = (2..number).to_a  
  prime_list = []
  
  while num_list.length > 0
    prime_list << num_list[0]
    num_list = num_list.select { |x| !((x%prime_list[-1])==0) }
  end  

  return prime_list
end

# 1. Use precomputed prime list upto 200 to eliminate
# 2. If number is not divisible by precomputed list
# 3. Generate numbers of form 6k + 1, 6k - 1 upto sqrt(n) to divide number
# 4. If not divisible number is prime

$primes_upto_200 = get_primes_eras(200)

def num_prime?(number)
  
  i=0
  while i < $primes_upto_200.length && number > $primes_upto_200[i]
    #puts "Debug[num_prime?]: i:#{i} $primes_upto_200[i]:#{$primes_upto_200[i]}"
    if number%$primes_upto_200[i]==0
      return false
    end    
    i = i + 1
  end
  limit = Math.sqrt(number).to_i

  #already divided upto the last prime before 200(199), take off from there
  k=34
  while k < limit
    if number%(6*k+1)==0 || number%(6*k-1)==0
      return false
    end
    k = k + 1
  end

  #if not divisible number is prime
  return true
      
end


### Main Program ###
#euler3_number = 600851475143

def largest_prime_factor(euler3_number)
  euler3_number_root = Math.sqrt(euler3_number).to_i
  i = euler3_number_root
  while i > 1
    if euler3_number % i == 0
      #puts "Debug: Checking #{i} for primality"
      if num_prime?(i) == true
        puts "Largest prime factor of #{euler3_number} is #{i}"
        return "Found it"
      end
    end  
    i = i - 1 
  end
  return "No factors"
end

def calculate_prime
  start = Time.now
  largest_prime_factor(600851475143)
  puts Time.now - start
end
