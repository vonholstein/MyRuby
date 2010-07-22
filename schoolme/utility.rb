require 'date'

class DateOfBirth
  
  def initialize(date)
    @date = date
  end

  def DateOfBirth.parseDate(date)
    #date_match = date.match(/([0-3]?[0-9])\/([0-1]?[1-9])\/(\d{4})/)
    Date.parse(date)
  end

  def to_s
    @date.julian
  end  
  
end
