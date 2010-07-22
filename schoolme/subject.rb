class Subject
  attr_accessor :teachers, :grades

  def initialize(teachers=[],grades=[])
    @teachers, @grades = teachers, grades
  end

end
