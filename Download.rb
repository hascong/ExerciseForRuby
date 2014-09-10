#!/usr/bin/ruby

require 'net/http'

#part of base library
website_base = "book.kiipedu.com"

for current_page in 1..228
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=D&fc=DDF&fn=" + current_page.to_s)
    open(current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

puts "Done ^_^"
