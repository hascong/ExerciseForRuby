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

# ary = [0,1,4,5,6,7,8,9,12,26,45,67,78,90,98,123,211,234,456,769,865,2345,3215,14345,24324] 
# [0,42,45,24324,99999].each do |val|
#   i = ary.insert_position(val)
#   if i
#     puts "found #{val} at index #{i}: #{ary[i]}"
#   else
#     puts "#{val} not found in array"
#   end
# end

puts "ReadFile.rb starts working..."
folderPath = "~/"

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
  anEntry = [ word, examples ] 
end

# (Optional) Sort all the entries ascendingly

# Search for the index to insert for the new word
indexInsert = allEntries.insert_position(ARGV[0])

# Insert the new word
newEntry = ARGV
# puts indexInsert
# puts newEntry
 # Insert newEntry at indexInsert, and shift trailing items toward end
if ($exists) then
  allEntries[indexInsert].push(ARGV[1..-1])
else
  allEntries.insert(indexInsert, newEntry)  
end

# Output a new file
puts allEntries
