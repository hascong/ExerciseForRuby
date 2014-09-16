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
    	# convert the whole string to entry arrays
    delimiter = "=="
    allLines.gsub!(/\n  /,delimiter)
    allLines.gsub!(/$/,delimiter)
    allLines = allLines[0..-3]
    @entries = allLines.scan(/^.+$/)
    
    # Split out the word and examples for each entry
        @entries.map! do |anEntry|
          # puts "anEntry in initialize function is #{anEntry}"
          # Copy an entry and add a new line character
          # Cut an entry into lines
          roughCut = anEntry.split(delimiter)
          
          if(roughCut.empty?) then
            anEntry = nil
          else
            # Remove the trailing new line character
            word = roughCut.first
            
            # Remove the word
            examples = roughCut[1..-1]
            
            # Re-format this entry
            anEntry = examples.insert(0, word)
          end
        end

        @entries.compact!

  end

public
  
  def search_word(word)
    indexInsert = @entries.insert_position(word)
    puts "searched word index is: #{indexInsert}"
    if(@entries[indexInsert][0]!=nil)
      if(@entries[indexInsert][0]==word) 
         return  @entries[indexInsert].to_s
      else
         return "NOT FOUND"
      end
    end
  end

  def insert_word(word,examples)
      # puts "I am the method in class with para "+word +" and "+examples.to_s
      # Search for the index to insert for the new word
    indexInsert = @entries.insert_position(word)
    puts "the insert index for word  "+ word + " is :"+indexInsert.to_s
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
          # puts "low is #{low} and high is #{high}"
          if (high.eql? low) then
              if (val < self[low][0]) then
                  # puts "1"
                  low
              else
                  # puts "2"
                  low
              end
          elsif (high.eql? (low + 1)) then
              if (val < self[low][0]) then
                  # puts "3"
                    low
              elsif (val < self[high][0]) then
                    # puts "4"
                    high-1
              else
                    # puts "5"
                    high
              end
          else
              mid = (low + high) / 2 # (2 + 3) / 2 => 2
              # puts "mid value is #{self[mid][0]}, comparing with value equal is #{val == self[mid][0]}"
              case
              when (val < self[mid][0]) then insert_position(val, low, mid - 1)
              when (val > self[mid][0]) then insert_position(val, mid + 1, high)
              else
                  # puts "6"
                  mid
              end
          end   
      end
  end
