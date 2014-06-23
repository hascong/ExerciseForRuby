class Vocabulary
  # entries array example
  # [god] [God is a girl.] [In God, we believe.]
  attr_accessor :entries
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
    	# read contents from file
    vocabBankFile = File.open(filepath,"r")
    allLines = vocabBankFile.read
    vocabBankFile.close
     	# read contents from file
    vocabBankFile = File.open(filepath,"r")
    allLines = vocabBankFile.read
    vocabBankFile.close
    	# convert the whole string to entry arrays
    delimiter = "=="
    allLines.gsub!(/\n  /,delimiter)
    allLines.gsub!(/$/,delimiter)
    allLines = allLines[0..-3]
    @entries = allLines.scan(/^.+$/)
    
    # Split out the word and examples for each entry
        @entries.map! do |anEntry|
          # Copy an entry and add a new line character
          # Cut an entry into lines
          roughCut = anEntry.split(delimiter)
          
          # Remove the trailing new line character
          word = roughCut.first
          
          # Remove the word
          examples = roughCut[1..-1]
          
          # Re-format this entry
          anEntry = examples.insert(0, word) 
        end
  end

public
  
  def search_word(word)
    indexInsert = @entries.insert_position(word)
    if(@entries[indexInsert][0]==word) 
       return  @entries[indexInsert].to_s
    else
       return "NOT FOUND"
    end   
  end

  def insert_word(word,examples)
      # puts "I am the method in class with para "+word +" and "+examples.to_s
      # Search for the index to insert for the new word
    indexInsert = @entries.insert_position(word)-1
    puts "the insert index is: "+indexInsert.to_s
    if(@entries[indexInsert][0]==word) then
        @entries[indexInsert]+= examples
    else
        newentry = examples.insert(0,word)
        @entries.insert(indexInsert,newentry)
    end
    # backup the old vacabulary and make a new one
     time = Time.now
     postfix = time.inspect.gsub!(/\s/,'_')
     filebackup = @filepath + postfix
     system "cp -f #{@filepath} #{filebackup}"
     # rewrite the vocabulary
     vocabBankFileRevised = File.open("#{@filepath}", "w")
     @entries.each do |anEntry|
       # puts "anEntry = #{anEntry}\n"
       vocabBankFileRevised.write("#{anEntry[0]}\n")
       examples = anEntry[1..-1]
       # puts "examples = #{examples}\n"
       examples.each do |anExample|
          vocabBankFileRevised.write("  #{anExample}\n")
       end
     end
     vocabBankFileRevised.close  
    return @entries[indexInsert].to_s
  end

end
  
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
                  mid
              end
          end
      end
  end
