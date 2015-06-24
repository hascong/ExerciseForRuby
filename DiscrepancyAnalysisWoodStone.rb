#! /usr/bin/ruby
#encoding: UTF-8

require 'net/http' # for Net::HTTP.get()

# Open the file where the analysis result is to be written
File.open("/Users/congliu/Desktop/discrepancy_analysis_woodstone", 'w') { |fileOutput| 

# folderPath = "/Users/congliu/Downloads/"

# TASK: Set the file to the correct name (1).
# NOTE: (1) Current job is about organic data file (Jan 2014 to Apr 2015)
filePath = "/Users/congliu/Desktop/35675-169434_woodstone-missing_installs/log_unity_ads_copy.csv"

# TASK: Set the line counter to 1
counterLine = 1
maxLine = 1108 # 1108
# 1,108 lines

fileInput = File.new(filePath, "r")

# TASK: Define a function that query the install using the Google AID
def query_install_log_given_google_aid(googleAdvertisingId)
  apiKey = "31cebeb7a3ef9452a3f3c2e01c0fc553" # "31cebeb7a3ef9452a3f3c2e01c0fc553" is Cong Liu's API key in WoodStone (169434).
  
  # The API call to get the install log, given Google advertising ID
  # Variables: 1. apiKey 2. googleAdvertisingId 
  url1 = "https://api.mobileapptracking.com/v2/advertiser/stats/installs/find.json?api_key=#{apiKey}&page=1&limit=100&fields=created%2Csite.name%2Cpublisher.name%2Ccampaign_url.name%2Cmatch_type%2Cis_view_through%2Cstatus%2Cstatus_code%2Cstat_click_id%2Cid%2Creferral_url%2Cgoogle_aid%2Ccountry.name%2Ctest_profile.name%2Csite_id%2Cpublisher_id%2Ccampaign_url_id%2Ccountry_id%2Ctest_profile_id&sort%5Bcreated%5D=desc&filter=(google_aid+%3D+%27#{googleAdvertisingId}%27)&group=test_profile_id%2Csite_id%2Cpublisher_id%2Ccampaign_url_id%2Ccountry_id&start_date=05%2F04%2F2015&end_date=05%2F14%2F2015&response_timezone=UTC&callback=jQuery1432791992783"

  htmlUriObject = URI(url1)
  resultJson = Net::HTTP.get(htmlUriObject)

  # TASK: Duplicate current line
  resultJsonDup = resultJson.dup

  # TASK: Retrieve log_install_id from the returned JSON result
  # NOTE: (2) After this statement, the value of lineDup is unexpected according to test results 
  # Example 1 (where log_install_id is found and can be retrieved):
  # {"status_code":200,"response_size":"565","data":[{"stat_click_id":null,"publisher_id":"0","site_id":83738,"campaign_url_id":null,"country_id":840,"test_profile_id":null,"created":"2015-05-04 03:04:09","match_type":null,"is_view_through":"0","status":"approved","status_code":null,"id":"ac5f5fdd76e9646f43-20150504-169434","referral_url":null,"google_aid":"50960429-4185-4b71-b466-861b4f106e8a","site":{"name":"Dark of the Demons Android"},"publisher":{"name":"organic"},"campaign_url":{"name":null},"country":{"name":"United States"},"test_profile":{"name":null}}]}
  # Example 2 (where the returned JSON has found no matching install given the Google AID):
  # {"status_code":200,"response_size":"50","data":[]} 
  logInstallId = resultJsonDup.gsub!(/{"status_code":200,[^,]+,"data":\[{.+"id":"([a-zA-Z0-9-]+)",.+/, "\\1")
  
  resultJsonDup = resultJson.dup
  attributedPublisher = resultJsonDup.gsub!(/{"status_code":200,[^,]+,"data":\[{.+"publisher":{"name":"([a-zA-Z0-9 -]+)"},.+/, "\\1")
  resultString = ""
  
  if (logInstallId)
    resultString << "#{logInstallId},#{attributedPublisher}"
  else
    resultString << "-,-,-"
  end

  if (logInstallId)
    # The API call to get the install log, given Google advertising ID
    # Variables: 1. apiKey 2. googleAdvertisingId 
    # url1 = "https://api.mobileapptracking.com/v2/advertiser/stats/installs/find.json?api_key=#{apiKey}&page=1&limit=100&fields=created%2Csite.name%2Cpublisher.name%2Ccampaign_url.name%2Cmatch_type%2Cis_view_through%2Cstatus%2Cstatus_code%2Cstat_click_id%2Cid%2Creferral_url%2Cgoogle_aid%2Ccountry.name%2Ctest_profile.name%2Csite_id%2Cpublisher_id%2Ccampaign_url_id%2Ccountry_id%2Ctest_profile_id&sort%5Bcreated%5D=desc&filter=(google_aid+%3D+%27#{googleAdvertisingId}%27)&group=test_profile_id%2Csite_id%2Cpublisher_id%2Ccampaign_url_id%2Ccountry_id&start_date=05%2F04%2F2015&end_date=05%2F14%2F2015&response_timezone=UTC&callback=jQuery1432791992783"
    url2 = "https://api.mobileapptracking.com/v2/advertiser/stats/postbacks/find.json?api_key=#{apiKey}&page=1&limit=100&fields=created%2Csite.name%2Ccampaign.name%2Cpublisher.name%2Csite_event.name%2Cconversion_postback.comment%2Cis_assist%2Curl%2Cid%2Cheaders%2Chttp_result%2Chttp_code%2Chttp_result_size%2Cstat_click_id%2Cstat_install_id%2Cpublisher_sub_publisher.name%2Cattributed_publisher.name%2Ctest_profile.name%2Csite_id%2Ccampaign_id%2Cpublisher_id%2Cattributed_publisher_id%2Csite_event_id%2Cconversion_postback_id%2Ctest_profile_id%2Cpublisher_sub_publisher_id%2Cpublisher_sub_publisher.ref&sort%5Bcreated%5D=desc&filter=(stat_install_id+%3D+%27#{logInstallId}%27)&group=attributed_publisher_id%2Ctest_profile_id%2Csite_id%2Ccampaign_id%2Cpublisher_id%2Csite_event_id%2Cconversion_postback_id%2Cpublisher_sub_publisher_id&start_date=05%2F04%2F2015&end_date=05%2F14%2F2015&response_timezone=UTC&callback=jQuery1432800830999" 
    
    htmlUriObject = URI(url2)
    resultJson = Net::HTTP.get(htmlUriObject)
   
    # TASK: Duplicate current line
    resultJsonDup = resultJson.dup
   
    # TASK: Retrieve log_install_id from the returned JSON result
    # NOTE: (2) After this statement, the value of lineDup is unexpected according to test results 
    # Example 1 (where log_install_id is found and can be retrieved):
    # {"status_code":200,"response_size":"565","data":[{"stat_click_id":null,"publisher_id":"0","site_id":83738,"campaign_url_id":null,"country_id":840,"test_profile_id":null,"created":"2015-05-04 03:04:09","match_type":null,"is_view_through":"0","status":"approved","status_code":null,"id":"ac5f5fdd76e9646f43-20150504-169434","referral_url":null,"google_aid":"50960429-4185-4b71-b466-861b4f106e8a","site":{"name":"Dark of the Demons Android"},"publisher":{"name":"organic"},"campaign_url":{"name":null},"country":{"name":"United States"},"test_profile":{"name":null}}]}
    # Example 2 (where the returned JSON has found no matching install given the Google AID):
    # {"status_code":200,"response_size":"50","data":[]} 
    
    logPostbackUrlId = resultJsonDup.gsub!(/{"status_code":200,[^,]+,"data":\[{.+"id":"([a-zA-Z0-9-]+)",.+/, "\\1")
    
    if (logPostbackUrlId) 
      resultString << ",#{logPostbackUrlId}"
    else
      resultString << ",-"
    end

  else
  end
 
  # TEST: if the resultString is correct 
  puts resultString 
  
  return resultString
end

# TASK: Add more columns into the output file 
# NOTE: (3) be careful of the new line character
#   .puts adds a new line character to the string parameter
#   .write does not add a new line character to the string parameter 
line = fileInput.gets.chop
fileOutput.puts "#{line},mat_log_install_id,mat_attributed_publisher,mat_log_postback_id"

# TASK: Append the found string to the current line
while (line = fileInput.gets.chop and counterLine < maxLine)
    # TASK: Duplicate current line
    puts "#{counterLine} #{line}"
    lineDup = line.dup

    # TASK: Retrieve referral_url from current line
    # NOTE: (4) After this statement, the value of lineDup is unexpected according to test results 
    # Example:
    # 2015-05-04T03:02:13.731Z,"ObjectId(""5530a6d4fe4dd51000000005"")",50960429-4185-4b71-b466-861b4f106e8a,
    googleAdvertisingId = lineDup.gsub!(/2015-05-[^,]+,"ObjectId[^,]+,([a-fA-F0-9-]+),.+/, "\\1")
    if (googleAdvertisingId)
        # When there is valid Google Advertising ID in the log from Unity Ads
        appendedString = query_install_log_given_google_aid(googleAdvertisingId)
    else
        # When the value is undefined for Google Advertising ID in the log from Unity Ads
        appendedString = ",-,-,-"
    end
   
    # TASK: Output the augmented current line into the output file 
    fileOutput.puts "#{line},#{appendedString}"
    
    # Increment line number counterLine
    counterLine = counterLine + 1
end

# Close input file
fileInput.close

# TEST: If yearMonthDetailed is correctly set
# fileOutput.write yearMonthDetailed

# End of program
# puts "--------------------------------------------------------------------------------"

# Close output file
}
