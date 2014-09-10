#!/usr/bin/ruby

require 'net/http'

#part of base library
website_base = "book.kiipedu.com"

# Level Beginner 1
for current_page in 1..208
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=D&fc=DDG&fn=" + current_page.to_s)
    open("./DDG/" + current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

# Level Beginner 2
for current_page in 1..200
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=D&fc=DDH&fn=" + current_page.to_s)
    open("./DDH/" + current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

# Level Intermediate 1
for current_page in 1..228
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=D&fc=DDE&fn=" + current_page.to_s)
    open("./DDE/" + current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

# Level Intermediate 2
for current_page in 1..228
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=D&fc=DDF&fn=" + current_page.to_s)
    open("./DDF/" + current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

# Understanding Korean Society
for current_page in 1..224
  puts "Waiting two seconds to process page " + current_page.to_s + " ..."
  sleep(5);
  
  puts "Downloading page " + current_page.to_s + " ..."
  Net::HTTP.start(website_base) { |http|
    resp = http.get("/Source/Viewer/img.php?fp=C&fc=CAG&fn=" + current_page.to_s)
    open("./CAG/" + current_page.to_s + ".jpeg", "wb") { |file|
      file.write(resp.body)
    }
  }
end

puts "Done ^_^"

