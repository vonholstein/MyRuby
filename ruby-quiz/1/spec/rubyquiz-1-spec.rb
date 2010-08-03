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
    deck.cards[52].should eql(RubyQuiz1::Card.new deck, face: 'J')
    deck.cards[53].should eql(RubyQuiz1::Card.new deck, face: 'J')
  end  
  it "should randomize 52 cards" do
    # test 5 cards at random, it should not be in its default positions"
    pending
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
    25.times do
      keystream << solitaire.get_keycode
    end
    keystream.should === solitaire_key.join
  end
  it "should always generate the same key for a given deck configuration " do
  end
end





