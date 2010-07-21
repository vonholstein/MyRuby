class Crypto

  attr_reader :message, :char_group
  
  def initialize(message)
    @message = message
  end

  def group_message
    # uppercase string and discard all non-alphabetic characters
    char_array = message.chars.map(&:upcase).select { |x| x >= "A" && x <= "Z" }
    # group in sets of 5 characters
    @char_group = []
    0.step(char_array.length-1,5) do |i|
      char_group << char_array[i...(i+5)].join
    end    
    @char_group
  end
  
end
