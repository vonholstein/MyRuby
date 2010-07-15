class School
  attr_accessor :students, :teachers, :grades

  def initialize(students=[],teachers=[],grades=[])
    @students, @teachers, @grades = students, teachers, grades
  end

  def register_student(student)
    @students
  end

end
