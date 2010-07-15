class Student
  attr_accessor :name, :age, :sex, :subjects, :grade

  def initialize(grade=nil)
    @age = 0
  end  
end

class Subject
  attr_accessor :teachers, :grades

  def initialize(teachers=[],grades=[])
    @teachers, @grades = teachers, grades
  end

end

class School
  attr_accessor :students, :teachers, :grades

  def initialize(students=[],teachers=[],grades=[])
    @students, @teachers, @grades = students, teachers, grades
  end

end

class Grade
  attr_accessor :level, :students, :criteria

  def initialize(level,students=[])
    @level, @students = level, students
  end

  def to_s
    "Grade" + " " + @level.to_s
  end  
end

  
