# Tests for school class
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), "..") #include parent directory

require 'school'

describe "school" do
  it "should be able to register students"
  it "should be able to hire teachers"
  it "should be able to add subjects"
  it "should be able to add grades"
end

