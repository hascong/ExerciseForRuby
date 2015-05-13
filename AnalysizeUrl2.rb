#! /usr/bin/ruby
#encoding: UTF-8

File.open("/Users/congliu/Desktop/organic_analysis_1", 'w') { |fileOutput| 

# fileOutput.write "--------------------------------------------------------------------------------"
# fileOutput.write "Starts working..."
folderPath = "/Users/congliu/Downloads/"

# TASK: Set the file to the correct name (1).
# NOTE: (1) Current job is about fingerprint data file (Nov 2014 to Apr 2015)
filePath = "/Users/congliu/Downloads/tmp-1431069285-604800-554c6265d15e7_copy_2.csv"
# TEST: If the file path has been correctly set
# fileOutput.write "The file is set to #{filePath}"

# TASK: Set the line counter to 1
counterLine = 1
maxLine = 965064 
# 1141762 lines for fingerprint 2014 11 12 2015 01 02 03 04
# 965065 lines for organic 2014 11 12
# lines for organic 2015 01 02 03 04

# TEST: If counterLine is set to 1
# fileOutput.write "The line counter has been set to #{counterLine}"

fileInput = File.new(filePath, "r")
keyValuePairs = Array.new
bankPatternsReferralUrl = Hash.new

yearMonthDetailed = Hash({"2014-11" => Hash.new, "2014-12" => Hash.new})
# yearMonthDetailed = Hash({"2015-01" => Hash.new, "2015-02" => Hash.new, "2015-03" => Hash.new, "2015-04" => Hash.new}) 
# yearMonthDetailed = Hash({"2014-11" => Hash.new, "2014-12" => Hash.new, "2015-01" => Hash.new, "2015-02" => Hash.new, "2015-03" => Hash.new, "2015-04" => Hash.new}) 

# TASK: Ignore the first line that is fields names
line = fileInput.gets.chop
# TEST: If the first line is correctly retrieved
# fileOutput.write "The first line is #{line}"

while (line = fileInput.gets.chop and counterLine < maxLine)
    # TASK: Retrieve current line
    # TEST: If current line is correctly retrieved
    # puts "Line #{counterLine}=[#{line}]"
    
    # TASK: Duplicate current line
    lineDup = line.dup
    # TEST: If current line is correctly duplicated
    # fileOutput.write "Line #{counterLine} duplicated: #{lineDup}"

    # TASK: Retrieve referral_url from current line
    # NOTE: (2) After this statement, the value of lineDup is unexpected according to test results 
    referral_url = lineDup.gsub!(/"[^,]+,"Coupang\ Android",organic,"?([^",]+)"?,.+/, "\\1")
    # TEST: if referral_url is correctly retrieved
    if (referral_url)
        # fileOutput.write "Line #{counterLine}'s referral_url: #{referral_url}"
    end

    # TASK: Split referral_url as key-value pairs and put them into an array
    if (referral_url)
        keyValuePairs = referral_url.split(/[?&]/)
    end
    # TEST: if key value pairs are correctly retrieved
    if (referral_url) 
        # fileOutput.write "Line #{counterLine}'s referral_url's key-value pairs: #{keyValuePairs}"
    end

    # TASK: Retrieve current referral_url pattern
    if (referral_url)
        keyValuePairs = keyValuePairs.join(",").gsub(/([^=&,]+)=[^,]*(,|$)/, "\\1\\2").split(",")
    end
    # TEST: If current referral_url pattern is correctly retrieved
    if (referral_url)
      # fileOutput.write "Line #{counterLine}'s referral_url's pattern: #{keyValuePairs}"
    end
    
    # TASK: Sort current referral_url pattern
    if (referral_url)
        keyValuePairs = keyValuePairs.sort
    end
    # TEST: If current referral_url pattern is correctly sorted
    if (referral_url)
      # fileOutput.write "Line #{counterLine}'s referral_url's pattern (sorted ascending): #{keyValuePairs}"
    end

    # TASK: Increment the value of the current referral URL pattern as the key in the pattern bank
    if (referral_url)
        if (bankPatternsReferralUrl[keyValuePairs.join(",")])
            bankPatternsReferralUrl[keyValuePairs.join(",")] = bankPatternsReferralUrl[keyValuePairs.join(",")] + 1
        else
            bankPatternsReferralUrl[keyValuePairs.join(",")] = 1
        end
    end
    # TEST: If the pattern bank is updated correctly
    if (referral_url)
        # fileOutput.write "The updated bankPatternsReferralUrl is:"
        # fileOutput.write "#{bankPatternsReferralUrl}"
    end

    # TASK: Write results into output file
    # TEST: If results are written into output file correctly 

    # TASK: Count for each month
    
    # TASK: Get another duplicate of current line
    lineDup = line.dup
    # TEST: If this another duplicate of current line is correctly retrieved
    # puts "Line #{counterLine} duplicated:[#{lineDup}]"

    # TASK: Retrieve YYYY-MM formatted year-month
    # NOTE: (3) After this statement, the value of lineDup is unexpected according to test results 
    yearMonth = lineDup.gsub!(/"(20\d\d-\d\d)[^,]+,"Coupang\ Android",organic,.+/, "\\1")
    # TEST: if the year-month is correctly retrieved
    if (yearMonth)
        # puts "Line #{counterLine}'s year-month=[#{yearMonth}]"
    end

    # TASK: Increment the value of the current referral URL pattern as the key in the pattern bank
    if (referral_url and yearMonth)
        # fileOutput.write yearMonthDetailed[yearMonth]
        if (yearMonthDetailed[yearMonth][keyValuePairs.join(",")])
            yearMonthDetailed[yearMonth][keyValuePairs.join(",")] = yearMonthDetailed[yearMonth][keyValuePairs.join(",")] + 1
        else
            yearMonthDetailed[yearMonth][keyValuePairs.join(",")] = 1
        end
    end
    # TEST: If the pattern bank is updated correctly
    if (referral_url)
        # fileOutput.write "The updated yearMonthDetailed[yearMonth] is:"
        # fileOutput.write "#{yearMonthDetailed[yearMonth]}"
    end
    
    # Increment line number counterLine
    counterLine = counterLine + 1
    # fileOutput.write ""
end

# Close input file
fileInput.close

# TEST: If yearMonthDetailed is correctly set
fileOutput.write yearMonthDetailed

# End of program
# puts "--------------------------------------------------------------------------------"

# Close output file
}
