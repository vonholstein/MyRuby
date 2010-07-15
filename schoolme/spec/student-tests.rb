# Tests for student class
$: << '/home/hnahas/my-ruby/schoolme'

require 'student'

describe "age of student" do
  before(:each) do
    @student = Student.new
  end  

  it "should not be less than 0" do
    @student.should have_at_least(0).age
  end

end

describe "student" do
  before(:each) do
    @student = Student.new
  end  

  it "should be able to join a grade" do    
    grade_1 = Grade.new(1)
    @student.join_grade(grade_1)
    @student.grade.should eql(grade_1)
  end  

  it "should not be able to join a grade without a school"

  it "should not be able to join a school without a grade"
  
end
