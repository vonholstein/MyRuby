class Student
  attr_accessor :id, :name, :sex, :subjects, :grade, :school

  # school is compulsory, student details are in a hash  
  def initialize(school,student_details)
    @school = school
    @id = school.nextId
    @name = student_details[:name]
    @dob = DateOfBirth.parseDate(student_details[:dob])
    @sex = student_details[:sex]
    # @subjects = student_details[:subjects].map { |s| Subject.new(s) }
    # @grade = Grade.new(student_details[:grade])
  end

  def dob
    @dob.to_s
  end
  
end
