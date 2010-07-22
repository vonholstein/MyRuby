class Grade
  attr_accessor :level, :students, :criteria

  def initialize(level,students=[])
    @level, @students = level, students
  end

  def to_s
    "Grade" + " " + @level.to_s
  end  
end
