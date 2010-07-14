

# Get max value for generating numbers
#max_number = Integer(gets)
#rescue ArgumentError
#exit

# Monkey patch the Array class to support swap
class Array
  def swap!(i,j)
    exit if i >= self.length || j >= self.length
    temp = self[i]
    self[i] = self[j]
    self[j] = temp
  end  
end

# Bubble sorting class

class MyBubbleSort

  def self.sort(number_array)
    temp_number_array = number_array.slice(0..-1)
    for i in (0...temp_number_array.length)
      for j in (i+1...temp_number_array.length)        
        temp_number_array.swap!(i,j) if temp_number_array[i] > temp_number_array[j]
      end
    end
    temp_number_array
  end
  
end




