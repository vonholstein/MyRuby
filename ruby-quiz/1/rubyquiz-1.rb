module RubyQuiz1
  
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

  class InvalidCardException < Exception
  end  

  class Deck

    CARD_FACES = ['C','D','H','S']
    CARD_NUMBERS = (1..13).to_a
    JOKER = 'J'

    attr_reader :cards
    
    def initialize()
      # @cards = Card.new(54)
      @cards = CARD_FACES.product(CARD_NUMBERS).collect { |x| Card.new(self, number: x[1], face: x[0]) }
      @cards.push Card.new face:JOKER  # add two jokers
      @cards.push Card.new face:JOKER
    end
    
  end

  class Card
    include Comparable
    
    attr_reader :number, :face
    
    def initialize(deck, card)

      if card[:face] == RubyQuiz1::Deck::JOKER
        @face = RubyQuiz1::Deck::JOKER
        return
      end      
        
      if card.has_key?(:number)        
        raise InvalidCardException unless RubyQuiz1::Deck::CARD_NUMBERS.include? card[:number]
        @number = card[:number]
      end

      if card.has_key?(:face)
        raise InvalidCardException unless RubyQuiz1::Deck::CARD_FACES.include? card[:face]
        @face = card[:face]
      end

      @deck = deck
    end

    def joker?
      @face == RubyQuiz1::Deck::JOKER
    end

    # Equality logic for cards
    # Two cards ar equal if they are both jokers or if they have the same number and face
    # Card A is less than Card B if face A < face B
    # If faces are equal Card A is less than Card B if number A < number B
    def <=>(other_card)
      if (self.joker? && other_card.joker?) || [self.number,self.face] == [other_card.number,other_card.face]
        return 0
      elsif RubyQuiz1::Deck::CARD_FACES.index(self.face) < RubyQuiz1::Deck::CARD_FACES.index(other_card.face)
        return -1
      elsif RubyQuiz1::Deck::CARD_FACES.index(self.face) > RubyQuiz1::Deck::CARD_FACES.index(other_card.face)
        return 1
      else
        (self.number < other_card.number)? -1 : 1
      end
    end

    def to_s
      if self.joker?
        return 'J'
      else
        return self.number.to_s + self.face.to_s
      end      
    end
    
    
  end  
  
end
