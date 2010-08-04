module RubyQuiz1
  class Crypto
    
    def self.group_message(message)
      # uppercase string and discard all non-alphabetic characters
      char_array = message.chars.map(&:upcase).select { |x| x >= "A" && x <= "Z" }
      # group in sets of 5 characters
      char_group = []
      0.step(char_array.length-1,5) do |i|
        char_group << char_array[i...(i+5)].join
      end    
      char_group
    end

    # solitaire_key is a string
    def self.encrypt(message,solitaire_key)
      # sanitize message and join      
      msg = group_message(message).join
      key = group_message(solitaire_key).join
      raise SolitaireKeyException unless msg.length == key.length
      encrypted_message = ""
      0.upto(msg.length-1) do |i|
        enc_code = ((msg[i].ord - 64) + (key[i].ord - 64)).modulo 26
        enc_code = 26 if enc_code == 0
        encrypted_message << (enc_code + 64).chr
      end
      encrypted_message
    end

    def self.decrypt(enc_message,solitaire_key)
      enc_message = group_message(enc_message).join
      key = group_message(solitaire_key).join
      raise SolitaireKeyException unless enc_message.length == key.length
      decrypted_message = ""
      0.upto(enc_message.length-1) do |i|
        dec_code =
          if enc_message[i].ord <= key[i].ord
            enc_message[i].ord + 26 - key[i].ord
          else
            enc_message[i].ord - key[i].ord
          end
        decrypted_message << (dec_code + 64).chr
      end
      decrypted_message
    end    
    
  end

  class InvalidCardException < Exception
  end

  class SolitaireKeyException < Exception
  end

  class InvalidDistanceException < Exception
  end

  class Card
     include Comparable

     attr_reader :number, :face
     attr_accessor :deck

     # If card face is joker initialize joker and return
     # else initialize card with number and face
     def initialize(deck, card)
       if deck
         raise InvalidCardException unless (deck.class.card_numbers.include?(card[:number]) && deck.class.card_faces.include?(card[:face])) || (deck.class.joker_numbers.include?(card[:number]) && deck.class.joker == card[:face])
         @deck = deck
       end
       @face = card[:face]
       @number = card[:number]
     end

     def value
       if joker?
         return 53
       else
         @deck.class.card_faces.index(face) * 13 + number
       end
     end

     def joker?
       @face == deck.class.joker
     end

     # Equality logic for cards
     # Two cards ar equal if they are both jokers or if they have the same number and face
     # Card A is less than Card B if face A < face B
     # If faces are equal Card A is less than Card B if number A < number B
     def <=>(other_card)
       if [self.number,self.face] == [other_card.number,other_card.face]
         return 0
       elsif deck.card_faces.index(self.face) < deck.card_faces.index(other_card.face)
         return -1
       elsif deck.card_faces.index(self.face) > deck.card_faces.index(other_card.face)
         return 1
       else
         (self.number < other_card.number)? -1 : 1
       end
     end

     def to_s
         return self.number.to_s + self.face.to_s
     end

     alias_method :eql?, :==
   end

   class Deck

     attr_reader :cards, :keyed

     @@card_faces = ['C','D','H','S']
     @@card_numbers = (1..13).to_a # ace to king and two jokers
     @@joker = 'J'
     @@joker_numbers = ['A','B']
     @keyed = false

     def initialize(populate=true)
       return true unless populate
       @cards = @@card_faces.product(@@card_numbers).collect { |x| Card.new(self, number: x[1], face: x[0]) }
       @cards.push Card.new self, number:'A',face: 'J'  # add two jokers
       @cards.push Card.new self, number:'B',face: 'J'
     end

     def Deck.card_faces
       @@card_faces
     end

     def Deck.card_numbers
       @@card_numbers
     end

     def Deck.joker
       @@joker
     end

     def Deck.joker_numbers
       @@joker_numbers
     end

     def key(strategy)
       @keyed = true
       # return the current card deck unless a strategy provided
       return self unless strategy
       # implement strategy
       # TODO
     end

     def [](i)
       @cards[i]
     end

     def move!(distance,card)
       # get index of card
       current_card_index = @cards.index card
       raise InvalidCardException unless current_card_index
       # delete the card at the current index preparatory to inserting it at the new index
       @cards.delete_at current_card_index
       # insert the card in the new position
       # if new position rolls over then move card past first card
       # if no rollover then plain insert will do
       if current_card_index + distance > 53
         new_card_index = ((current_card_index + distance).modulo 54) + 1
       else
         new_card_index = current_card_index + distance
       end
       card.deck = self
       @cards.insert new_card_index, card
     end

     def move_down!(distance,card)
       raise InvalidDistanceException if distance < 0
       move! distance, card
     end

     def move_up!(distance,card)
       raise InvalidDistanceException if distance < 0
       move! -distance, card
     end

     def triple_cut!
       joker_a_index = @cards.index Card.new(nil, number: 'A', face: 'J')
       joker_b_index = @cards.index Card.new(nil, number: 'B', face: 'J')
       top_joker_index = (joker_a_index < joker_b_index)?joker_a_index:joker_b_index
       bottom_joker_index = (joker_a_index < joker_b_index)?joker_b_index:joker_a_index
       # puts "top_joker_index = #{top_joker_index}"
       # puts "bottom_joker_index = #{bottom_joker_index}"
       # p "@cards = #{@cards}"
       # p @cards[0...top_joker_index]
       # p @cards[(bottom_joker_index+1)..-1]
       @cards = @cards[(bottom_joker_index+1)..-1] + @cards[top_joker_index..bottom_joker_index] + @cards[0...top_joker_index]
       # p @cards
     end
     
     def count_cut!
       bottom_card_value = @cards[-1].value
       @cards = @cards[bottom_card_value..-2] + @cards[0...bottom_card_value] + [@cards[-1]]
     end    

  end

  # return key codes
  # accepts a strategy shuffle the deck
  
  class Solitaire

    def initialize(strategy=nil)
      # intitialize deck
      @deck = Deck.new
      @deck.key(strategy)
    end

    def get_keycode
      @deck.move_down! 1,Card.new(nil, number:'A',face:'J')
      @deck.move_down! 2,Card.new(nil, number:'B',face:'J')
      @deck.triple_cut!
      @deck.count_cut!
      card_location = @deck[0].value
      if @deck[card_location].joker?
        # skip and try once more
        get_keycode
      else
        if @deck[card_location].value > 26
          ((@deck[card_location].value - 26) + 64).chr
        else
          (@deck[card_location].value + 64).chr
        end
      end
    end
    
  end
  
end

solitaire = RubyQuiz1::Solitaire.new
message = "Code in Ruby, live longer!"
encrypted_msg = ["CLEPK","HHNIY","CFPWH","FDFEH"].join
keystream = ""
20.times do
  keystream << solitaire.get_keycode
end
decrypted_msg = RubyQuiz1::Crypto.decrypt(encrypted_msg,keystream)
puts decrypted_msg

