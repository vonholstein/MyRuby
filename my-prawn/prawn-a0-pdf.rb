$: << '/usr/local/rvm/gems/ruby-1.8.7-p299/gems/Ascii85-1.0.0/lib'
$: << '/usr/local/rvm/gems/ruby-1.8.7-p299/gems/pdf-reader-0.8.5/lib'
$: << '/home/habibnahas/ruby-projects/prawn/lib'

require 'prawn'
pdf = Prawn::Document.new
pdf.text("Prawn Rocks")
pdf.render_file('prawn.pdf')
