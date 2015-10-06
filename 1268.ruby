#! /usr/bin/ruby
#encoding: UTF-8

require 'net/http' # for Net::HTTP.get()

# Open the file where the analysis result is to be written
File.open("/Users/congliu/Desktop/1268-script-output", 'w') { |fileOutput| 

# folderPath = "/Users/congliu/Downloads/"

# TASK: 
# NOTE: 
filePath = "/Users/congliu/Desktop/1268-script-input"

# TASK: 

fileInput = File.new(filePath, "r")

# TASK: 
def query(apiKey)
# Yellomobile (advertiser ID 20010)
#  appIdArray = [
#    57394, # Coocha
#    57430, # Couponmoa
#    57474, # Coocha (apple)
#    83942, # Coocha_homeshopping
#    90438, # com.yellomobile.CCShopping
#    93518 # Global Shopping
#  ]

# Ticketmonster (advertiser ID 21278)
#  appIdArray = [
#    61758, # iOS
#    61862  # Android
#  ]  

# Gaea (advertiser ID 169076)
#  appIdArray = [
#    83434, # KR_Dotap_And_google
#    83450, # KR_Dotap_iOS
#    85582, # 도탑전기_And_nstore
#    85588, # 도탑전기_And_tstore
#    96640, # 가디언즈배틀_nstore
#    96642, # 가디언즈배틀_tstore
#    99290, # KR_GuardiansBattle_And_Google
#    101520, # KR_GuardiansBattle_iOS
#    104818, # EN_AOA_And_Google
#    104852, # EN_AOA_iOS
#    106770, # TW_100_And_Google
#    106772, # TW_100_iOS
#  ]

#Coupang (advertiser ID 10896)
#  appIdArray = [
#    35404, # Coupang IOS
#    36588, # Coupang Android
#  ]

#JobPlanet (advertiser ID 188532)
#  appIdArray = [
#    102966
#  ]

#GS Shop (advertiser ID 19082)
  appIdArray = [
    55700, # iOS-GS SHOP
    55218  # GS SHOP
  ]

  # date range 20150924UTC9 to 20150926UTC9 inclusive
  dayArray = [24, 25, 26];
  
  # install logs
  puts
  puts "install logs numbers:"
  puts 
  for j in 0..(dayArray.count - 1)
    for i in 0..(appIdArray.count - 1)
      url = "https://api.mobileapptracking.com/v2/advertiser/stats/installs/count.json?page=1&limit=100&fields=created%2Csite.name%2Cpublisher.name%2Cpayout%2Ccountry.name%2Csite_id%2Cpublisher_id%2Ccountry_id&sort%5Bcreated%5D=desc&filter=(status+%3D+'approved')+AND+(site_id+%3D+'#{appIdArray[i]}')+AND+((debug_mode%3D0+OR+debug_mode+is+NULL)+AND+(test_profile_id%3D0+OR+test_profile_id+IS+NULL))&group=site_id%2Cpublisher_id%2Ccountry_id&start_date=09%2F#{dayArray[j]}%2F2015&end_date=09%2F#{dayArray[j]}%2F2015&response_timezone=Asia%2FSeoul&api_key=#{apiKey}"
      htmlUriObject = URI(url)
      resultJson = Net::HTTP.get(htmlUriObject)
      puts "date=#{dayArray[j]} app_id=#{appIdArray[i]}"
      puts resultJson;
      system ("sleep 5"); 
    end
  end

  # event logs
  puts
  puts "event logs numbers:"
  puts 
  for j in 0..(dayArray.count - 1)
    for i in 0..(appIdArray.count - 1)
      url = "https://api.mobileapptracking.com/v2/advertiser/stats/events/count.json?page=1&limit=100&fields=created%2Csite.name%2Cpublisher.name%2Csite_event.name%2Cpayout%2Crevenue_usd%2Csite_id%2Cpublisher_id%2Csite_event_id%2Cid%2Crevenue%2Ccurrency_code%2Csite_event_items_count&sort%5Bcreated%5D=desc&filter=(status+%3D+'approved')+AND+(site_id+%3D+'#{appIdArray[i]}')+AND+((debug_mode%3D0+OR+debug_mode+is+NULL)+AND+(test_profile_id%3D0+OR+test_profile_id+IS+NULL))&group=site_id%2Cpublisher_id%2Csite_event_id&start_date=09%2F#{dayArray[j]}%2F2015&end_date=09%2F#{dayArray[j]}%2F2015&response_timezone=Asia%2FSeoul&api_key=#{apiKey}"
      htmlUriObject = URI(url)
      resultJson = Net::HTTP.get(htmlUriObject)
      puts "date=#{dayArray[j]} app_id=#{appIdArray[i]}"
      puts resultJson;
      system ("sleep 5"); 
    end
  end

end

#Yellomobile
#apiKey = "e73f9feba13725b79f7d3e27ad787617"

#Ticketmonster
#apiKey = "888e3a44e06e0f0e08a2938c686ce858"

#Gaea Korea
#apiKey = "d14685beb4fb1fdb932e226b0026250d"

#Coupang
#apiKey = "ff981cd7a7243502f3956924b7bf5a32"

#JobPlanet
#apiKey = "2ad5c2b24a7a1f24bef1803c0b36e672"

#GS Shop
apiKey = "7e485ba0035b7fa215636daf984050fa"

query(apiKey)

# TASK: 
#fileOutput.puts "#{appendedString}"

# Close input file
fileInput.close

# End of program
# puts "--------------------------------------------------------------------------------"

# Close output file
}
