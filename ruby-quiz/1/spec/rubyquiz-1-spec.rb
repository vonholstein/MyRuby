# Tests for ruby quiz 1
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), "..") #include parent directory

require 'rubyquiz-1'

describe "Crypto" do
  it "should be able to prune and group characters" do
    message = "Code in Ruby, live longer!"
    crypto_1 = Crypto.new(message)
    crypto_1.group_message.should eql(["CODEI","NRUBY","LIVEL","ONGER"])
  end
  it "should group an array with non-boundary length" do
    message = "Code in Ruby, live long and prosper!"
    crypto_1 = Crypto.new(message)
    crypto_1.group_message.should eql(["CODEI","NRUBY","LIVEL","ONGAN","DPROS","PER"])
  end  
  it "should prune a garbage string to an empty array" do
    message = "0&(#&#&987304(^989&(7%_()*&"
    crypto_1 = Crypto.new(message)
    crypto_1.group_message.should eql([])
  end  
end

describe "Deck" do
  it "should have 52 cards"
  it "should have 52 cards in order Clubs,Diamonds,Hearts,Spades,Joker under default configuration" do
    deck = Deck.new
    dec.cards
  end  
  it "should randomize 52 cards"
end


