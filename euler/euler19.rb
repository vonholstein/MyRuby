require 'date'
o_date = Date.new(y=1901,w=1,d=1)
sun_count = 0
until(o_date.year==2000 && o_date.month==12 && o_date.day==31)
  sun_count += 1 if o_date.day == 1 && o_date.cwday==7
  o_date += 1
end

puts sun_count
