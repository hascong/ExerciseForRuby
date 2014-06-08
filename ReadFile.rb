#! /usr/bin/ruby
#encoding: UTF-8

# Usage
# word: ARGV[0]
# example: ARGV[1]

# Assumption
# the input word does not exist in current file

$exists = false

class Array
  def insert_position(val, low = 0, high = (length - 1))
    # return high if high < low
    if (high.eql? low) then
      if (val < self[low][0]) then
        low
      else
        low + 1
      end
    elsif (high.eql? (low + 1)) then
      if (val < self[low][0]) then
        low
      elsif (val < self[high][0]) then
        high
      else
        high + 1
      end
    else
      mid = (low + high) / 2 # (2 + 3) / 2 => 2
      case
        when (val < self[mid][0]) then insert_position(val, low, mid - 1)
        when (val > self[mid][0]) then insert_position(val, mid + 1, high)
        else
          $exists = true
          mid
      end
    end
  end
end

puts "ReadFile.rb starts working..."
folderPath = "/Users/congliu/"

# Read the file into a string
vocabBankFile = File.open("#{folderPath}vocab_bank_fake_small", "r")
allLines = vocabBankFile.read
vocabBankFile.close

# Join lines for each entry
delimiter = "=="
allLines.gsub!(/\n  /, delimiter)
allLines.gsub!(/$/, delimiter)
allLines = allLines[0..-3] # Now allLines[-1] is "\n"

# Split the whole string into entries
allEntries = allLines.scan(/^.+$/)

# puts "allEntries is:"
# puts allEntries
# puts ""

# Split out the word and examples for each entry
wordCount = 0
allEntries.map! do |anEntry|
  # Copy an entry and add a new line character
  wordCount += 1
  
  # Cut an entry into lines
  roughCut = anEntry.split(delimiter)
  
  # Remove the trailing new line character
  word = roughCut.first
  
  # Remove the word
  examples = roughCut[1..-1]

  # Re-format this entry
  anEntry = examples.insert(0, word) 
end

# (Optional) Sort all the entries ascendingly

# Search for the index to insert for the new word
indexInsert = allEntries.insert_position(ARGV[0])

# Insert the new word
newEntry = ARGV
# puts indexInsert
# puts newEntry
 # Insert newEntry at indexInsert, and shift trailing items toward end
puts "allEntries = #{allEntries}\n"
if ($exists) then
  allEntries[indexInsert] += ARGV[1..-1]
else
  allEntries.insert(indexInsert, newEntry)  
end

# Output a new file
 # (Debugging) puts allEntries
system "touch #{folderPath}vocab_bank_fake_small_revised"
system "chmod 766 #{folderPath}vocab_bank_fake_small_revised" 
vocabBankFileRevised = File.open("#{folderPath}vocab_bank_fake_small_revised", "w")

allEntries.each do |anEntry|
  puts "anEntry = #{anEntry}\n"

  vocabBankFileRevised.write("#{anEntry[0]}\n")
  
  examples = anEntry[1..-1]

  puts "examples = #{examples}\n"

  examples.each do |anExample|
    vocabBankFileRevised.write("  #{anExample}\n")
  end
end

vocabBankFileRevised.close
