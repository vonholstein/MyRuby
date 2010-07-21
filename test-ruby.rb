module InMod
  class MySuper
    def initialize(x)
      @test_value = x
    end
    def print_value
      puts "Super #{@test_value}"
    end    
  end
  class MySub < MySuper
    def print_value
      super(8)
      puts "Sub #{@test_value}"
    end
  end
end

  
