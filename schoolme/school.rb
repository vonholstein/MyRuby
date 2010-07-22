class School
  attr_accessor :students, :teachers, :grades
  
  def initialize(students=[],teachers=[],grades=[])
    @students, @teachers, @grades = students, teachers, grades
    @id = 0
  end

  def register_student(student)
    @students.push student
  end

  def nextId
    @id += 1
  end

end
