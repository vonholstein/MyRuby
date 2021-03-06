# Tests for ruby quiz 1
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), "..") #include parent directory

require 'rubyquiz-1'

describe "RubyQuiz1::Crypto" do
  it "should be able to prune and group characters" do
    message = "Code in Ruby, live longer!"
    RubyQuiz1::Crypto.group_message(message).should eql(["CODEI","NRUBY","LIVEL","ONGER"])
  end
  it "should group an array with non-boundary length" do
    message = "Code in Ruby, live long and prosper!"
    RubyQuiz1::Crypto.group_message(message).should eql(["CODEI","NRUBY","LIVEL","ONGAN","DPROS","PER"])
  end  
  it "should prune a garbage string to an empty array" do
    message = "0&(#&#&987304(^989&(7%_()*&"
    RubyQuiz1::Crypto.group_message(message).should eql([])
  end
  it "should convert message to numbers" do    
  end
  it "should encrypt a message correctly" do
    message = "Code in Ruby, live longer!"
    solitaire_key = "DWJXH YRFDG TMSHP UURXJ"
    encrypted_msg = RubyQuiz1::Crypto.encrypt(message,solitaire_key)
    encrypted_msg.should === ["GLNCQ","MJAFF","FVOMB","JIYCB"].join
  end
  it "should decrypt a message correctly" do
    message = "Code in Ruby, live longer!"
    encrypted_msg = ["GLNCQ","MJAFF","FVOMB","JIYCB"].join
    solitaire_key = "DWJXH YRFDG TMSHP UURXJ"
    decrypted_msg = RubyQuiz1::Crypto.decrypt(encrypted_msg,solitaire_key)
    decrypted_msg.should === RubyQuiz1::Crypto.group_message(message).join
  end
  it "should fail to decrypt without correct key" do
    message = "Code in Ruby, live longer!"
    encrypted_msg = ["HLNCQ","KJAFF","FVOMB","JIYCB"].join
    solitaire_key = "DWJXH YRFDG TMSHP UURXJ"
    decrypted_msg = RubyQuiz1::Crypto.decrypt(encrypted_msg,solitaire_key)
    decrypted_msg.should_not === RubyQuiz1::Crypto.group_message(message).join
  end  
end



describe "RubyQuiz1::Deck" do
  it "should have 54 cards" do
    deck = RubyQuiz1::Deck.new
    deck.cards.count.should eql(54)
  end
  it "should have cards in order Clubs,Diamonds,Hearts,Spades,Joker under default configuration" do
    deck = RubyQuiz1::Deck.new
    deck.cards[0].should eql(RubyQuiz1::Card.new deck, number: 1, face: 'C')
    deck.cards[1].should eql(RubyQuiz1::Card.new deck, number: 2, face: 'C')
    deck.cards[50].should eql(RubyQuiz1::Card.new deck, number: 12, face: 'S')
    deck.cards[51].should eql(RubyQuiz1::Card.new deck, number: 13, face: 'S')
    deck.cards[52].should eql(RubyQuiz1::Card.new deck, number: 'A', face: 'J')
    deck.cards[53].should eql(RubyQuiz1::Card.new deck, number: 'B',face: 'J')
  end  
  it "should move cards correctly(non-boundary,positive)" do
    deck = RubyQuiz1::Deck.new
    card = RubyQuiz1::Card.new deck, number: 12, face: 'S'
    shifted_card = RubyQuiz1::Card.new deck, number: 13, face: 'S'
    card_index = 50
    deck.move! 2, card
    deck.cards[card_index].should === shifted_card
    deck.cards[card_index+2].should === card
  end
  it "should move cards correctly(boundary,positive)" do
    deck = RubyQuiz1::Deck.new
    card = RubyQuiz1::Card.new deck, number: 'A', face: 'J'
    shifted_card = RubyQuiz1::Card.new deck, number: 'B', face: 'J' # at location card_index + 1
    card_index = 52
    shifted_card_index = card_index + 1
    deck.move! 3, card
    deck.cards[shifted_card_index].should === shifted_card # card after moving card remains in the same position since the card is moved to the front of the deck 1C,2C......AJ,BJ => 1C,2C,AJ.......13S,BJ
    deck.cards[2].should === card
  end
  it "should triple cut correctly" do
    deck = RubyQuiz1::Deck.new
    deck.move_down! 1, RubyQuiz1::Card.new(nil, number: 'A', face: 'J')
    deck[-1].should === RubyQuiz1::Card.new(deck, number: 'A', face: 'J')
    deck.move_down! 2, RubyQuiz1::Card.new(nil, number: 'B', face: 'J')
    deck[-1].should === RubyQuiz1::Card.new(deck, number: 'A', face: 'J')
    deck[0].should === RubyQuiz1::Card.new(deck, number: 1, face: 'C')
    deck[1].should === RubyQuiz1::Card.new(deck, number: 'B', face: 'J')
    deck.triple_cut!
    deck[0].should === RubyQuiz1::Card.new(deck, number: 'B', face: 'J')
    deck[1].should === RubyQuiz1::Card.new(deck, number: 2, face: 'C')
    deck[-1].should === RubyQuiz1::Card.new(deck, number: 1, face: 'C')
    deck[-2].should === RubyQuiz1::Card.new(deck, number: 'A', face: 'J')
  end
  it "should count cut correctly" do
    deck = RubyQuiz1::Deck.new
    deck.move_down! 1, RubyQuiz1::Card.new(nil,number: 'A', face: 'J')
    deck.move_down! 2, RubyQuiz1::Card.new(nil,number: 'B', face: 'J')    
    deck.triple_cut!
    deck.count_cut!
    deck[0].should === RubyQuiz1::Card.new(deck, number: 2, face: 'C')
    deck[1].should === RubyQuiz1::Card.new(deck, number: 3, face: 'C')
    deck[-1].should === RubyQuiz1::Card.new(deck, number: 1, face: 'C')
    deck[-2].should === RubyQuiz1::Card.new(deck, number: 'B', face: 'J')
  end
end

describe "RubyQuiz1::Card" do
  it "should return correct value for a card" do
    deck = RubyQuiz1::Deck.new false
    card = RubyQuiz1::Card.new deck, number: 13, face: 'C'
    card.value.should === 13    
  end
end
describe "RubyQuiz1::Solitaire" do
  it "should generate correct keystream for a given deck configuration" do
    deck_to_key = RubyQuiz1::Deck.new
    solitaire = RubyQuiz1::Solitaire.new
    solitaire_key = "DWJXH YRFDG TMSHP UURXJ"
    keystream = ""
    20.times do
      keystream << solitaire.get_keycode
    end
    keystream.should === solitaire_key.split.join
  end
  it "should always generate the same key for a given deck configuration " do
  end
end





