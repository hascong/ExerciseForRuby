#! /usr/bin/ruby
#encoding: UTF-8

File.open("/Users/congliu/Desktop/fingerprint_analysis", 'w') { |fileOutput| 

fileOutput.write "--------------------------------------------------------------------------------"
fileOutput.write "Starts working..."
folderPath = "/Users/congliu/Downloads/"

# TASK: Set the file to the correct name (1).
# NOTE: (1) Current job is about fingerprint data file (Nov 2014 to Apr 2015)
filePath = "/Users/congliu/Downloads/tmp-1431312123-604800-555016fbeb839_copy_2.csv"
# TEST: If the file path has been correctly set
puts "The file is set to #{filePath}"

# TASK: Set the line counter to 1
counterLine = 1
maxLine = 1141761
# 1141762 lines for fingerprint all

# TEST: If counterLine is set to 1
puts "The line counter has been set to #{counterLine}"

fileInput = File.new(filePath, "r")
keyValuePairs = Array.new
bankPatternsReferralUrl = Hash.new

yearMonthDetailed = Hash({"2014-11" => Hash.new, "2014-12" => Hash.new, "2015-01" => Hash.new, "2015-02" => Hash.new, "2015-03" => Hash.new, "2015-04" => Hash.new}) 

# TASK: Ignore the first line that is fields names
line = fileInput.gets.chop
# TEST: If the first line is correctly retrieved
puts "The first line is #{line}"

while (line = fileInput.gets.chop and counterLine < maxLine)
    # TASK: Retrieve current line
    # TEST: If current line is correctly retrieved
    # puts "Line #{counterLine}=[#{line}]"
    
    # TASK: Duplicate current line
    lineDup = line.dup
    # TEST: If current line is correctly duplicated
    # puts "Line #{counterLine} duplicated: #{lineDup}"

    # TASK: Retrieve referral_url from current line
    # NOTE: (2) After this statement, the value of lineDup is unexpected according to test results 
    referral_url = lineDup.gsub!(/"[^,]+,"Coupang\ Android",[^,]+,fingerprint,"?([^",]+)"?,[^,]+,[^,]+/, "\\1")
    # TEST: if referral_url is correctly retrieved
    if (referral_url)
        # puts "Line #{counterLine}'s referral_url: #{referral_url}"
    end

    # TASK: Split referral_url as key-value pairs and put them into an array
    if (referral_url)
        keyValuePairs = referral_url.split(/[?&]/)
    end
    # TEST: if key value pairs are correctly retrieved
    if (referral_url) 
        # puts "Line #{counterLine}'s referral_url's key-value pairs: #{keyValuePairs}"
    end

    # TASK: Retrieve current referral_url pattern
    if (referral_url)
        keyValuePairs = keyValuePairs.join(",").gsub(/([^=&,]+)=[^,]*(,|$)/, "\\1\\2").split(",")
    end
    # TEST: If current referral_url pattern is correctly retrieved
    if (referral_url)
        # puts "Line #{counterLine}'s referral_url's pattern: #{keyValuePairs}"
    end
    
    # TASK: Sort current referral_url pattern
    if (referral_url)
        keyValuePairs = keyValuePairs.sort
    end
    # TEST: If current referral_url pattern is correctly sorted
    if (referral_url)
        # puts "Line #{counterLine}'s referral_url's pattern (sorted ascending): #{keyValuePairs}"
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
        # puts "The updated bankPatternsReferralUrl is:"
        # puts "#{bankPatternsReferralUrl}"
    end

    # TODO: Write results into output file
    # TEST: TODO If results are written into output file correctly 

    # TODO: Count for each month
    
    # TASK: Get another duplicate of current line
    lineDup = line.dup
    # TEST: If this another duplicate of current line is correctly retrieved
    # puts "Line #{counterLine} duplicated: #{lineDup}"

    # TASK: Retrieve YYYY-MM formatted year-month
    # NOTE: (3) After this statement, the value of lineDup is unexpected according to test results 
    yearMonth = lineDup.gsub!(/"(20\d\d-\d\d)[^,]+,"Coupang\ Android",[^,]+,fingerprint,([^,]+,|,)[^,]+,[^,]+/, "\\1")
    # TEST: if the year-month is correctly retrieved
    if (yearMonth)
        # puts "Line #{counterLine}'s year-month:[#{yearMonth}]"
    end
    
    # TASK: Increment the value of the current referral URL pattern as the key in the pattern bank
    if (referral_url and yearMonth)
        if (yearMonthDetailed[yearMonth][keyValuePairs.join(",")])
            yearMonthDetailed[yearMonth][keyValuePairs.join(",")] = yearMonthDetailed[yearMonth][keyValuePairs.join(",")] + 1
        else
            yearMonthDetailed[yearMonth][keyValuePairs.join(",")] = 1
        end
    end
    # TEST: If the pattern bank is updated correctly
    if (referral_url)
        # puts "The updated yearMonthDetailed[yearMonth] is:"
        # puts "#{yearMonthDetailed[yearMonth]}"
    end
    
    # Increment line number counterLine
    counterLine = counterLine + 1
    # puts ""
end

# Close input file
fileInput.close

# TEST: If yearMonthDetailed is correctly set
fileOutput.write yearMonthDetailed

# End of program
fileOutput.write "--------------------------------------------------------------------------------"

# Close output file
}
