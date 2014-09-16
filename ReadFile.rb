#! /usr/bin/ruby
#encoding: UTF-8
require_relative 'Vocabulary.rb'


puts "ReadFile.rb starts working..."
folderPath = "/Users/Qing/git/ExerciseForRuby/"
filename = "vocab_bank_fake_small"

#read arguments
#-s hello                                                       means search for the word "hello"
#-i hello "Hello World." "Hello there." "Hello again."          means insert the word and its example(s)
#-e "Glass based two <symphonies,symphony> on <music> by rock musicians David Bowie and Brian Eno, but the symphonies' sound is <distinctively,distinctive> his."
option = ARGV[0]

vocab = Vocabulary.new(folderPath+filename)

if(option == "-i") then
     puts vocab.insert_word(ARGV[1],ARGV[2..-1])
elsif(option == "-s") then
     puts  vocab.search_word(ARGV[1])
elsif(option == "-e") then
     #  puts ARGV[1]
     extracts = ARGV[1].scan(/<[^>]+>/)
     if(extracts.size!=0) then
        extracts.each do |extract|
          # get new vocabulary string
          twowords = extract[1..-2].split(',')
          newword = (twowords[1]==nil) ? twowords[0] : twowords[1]
          #clean up useless notations like <> and ,
          example = ARGV[1].dup
          example.gsub!(/,\w*>/,'')
          example.gsub!(/</,'')
          example.gsub!(/>/,'')
          examples = Array.new
          examples.insert(0,example)
          
          vocab.insert_word(newword,examples)
        end
     end
end
