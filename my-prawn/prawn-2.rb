require "prawn/measurement_extensions"

Prawn::Document.generate(:page_layout => :portrait,
                         :left_margin => 10.mm,    # different
                         :right_margin => 1.cm,    # units
                         :top_margin => 0.1.dm,    # work
                         :bottom_margin => 0.01.m, # well
                           :page_size => 'A4') do
  text "Prawn Rocks"
end
