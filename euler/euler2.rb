#The prime factors of 13195 are 5, 7, 13 and 29.
#What is the largest prime factor of the number 600851475143 ?

#Algorithm #1
# Find factors of number, check if each factor is prime

#Algorithm #2
# Generate prime numbers upto less than square of number, see if the number can be divided with them
# Code generator that yields prime numbers upto certain amount

# Sieve of Erasthosthenes
# Create a list of consecutive integers from two to n: (2, 3, 4, ..., n),
# Initially, let p equal 2, the first prime number,
# While enumerating all multiples of p starting from p2, strike them off from the original list,
# Find the first number remaining on the list after p (it's the next prime); let p equal this number,
# Repeat steps 3 and 4 until p2 is greater than n.
# All the remaining numbers in the list are prime.

def get_primes_eras (number)

  num_list = (2..number).to_a  
  prime_list = []
  
  while num_list.length > 0
    prime_list << num_list[0]
    num_list = num_list.select { |x| !((x%prime_list[-1])==0) }
  end  

  puts prime_list
end

#prog_num = 10000
prog_num = 600851475143
primes = get_primes_eras(Math.sqrt(prog_num).to_i)


  



    
