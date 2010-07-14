class Animal
  
  def initialize(bAlive)

    if(bAlive)
      @alive = true
    else
      @alive = false
    end

  end

end

class Dog < Animal

  def set_name(name)

    @name = name

  end

  def get_name()

    @name

  end  

end

  
