#! /usr/bin/ruby
#encoding: UTF-8
require_relative 'Vocabulary.rb'


puts "ReadFile.rb starts working..."
folderPath = "/Users/Qing/git/ExerciseForRuby/"
filename = "vocab_bank_fake_small"

#read arguments
#-s hello                                                       means search for the word "hello"
#-i hello "Hello World." "Hello there." "Hello again."          means insert the word and its example(s)

option = ARGV[0]
word = ARGV[1]
examples = ARGV[2..-1]

vocab = Vocabulary.new(folderPath+filename)

if(option == "-i") then
     puts vocab.insert_word(word,examples)
elsif(option == "-s") then
     puts  vocab.search_word(word)
end
