# Tests for student class
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), "..") #include parent directory

require 'student'
require 'grade'
require 'school'
require 'utility'

describe "student" do

  it "should be able to join a grade" do    
    grade_1 = Grade.new(1)
    @student.join_grade(grade_1)
    @student.grade.should eql(grade_1)
  end  

  it "should be able to initialize with minimum required variables, school, name, dob, sex" do
    school_name = "My School"
    student_name = "Habib Nahas"
    student_dob = "16/07/1984"
    student_sex = "M"
    school_1 = School.new(school_name)
    student_1 = Student.new(school_1, name: student_name, dob: student_dob, sex: student_sex)
    student_1.name.should eql(student_name)
    student_1].dob.should eql(student_dob)
    student_1.sex.should eql(student_sex)
  end  
  
end
