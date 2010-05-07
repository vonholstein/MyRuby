#1. open the file and read into string
#2. get characters, words, sentences

file_string = File.open('G:\home\text.txt').readlines
puts file_string.join.sub('\s+',' ')
