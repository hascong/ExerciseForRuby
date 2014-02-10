#! /usr/bin/ruby
#encoding: UTF-8

require 'net/http' # to get html source

# inputs
year = "2014" # 2014
month = "02" # 01..12, 02 stands for Feb
day = "02" # 01..31
pages_range = 1..59 # page ranges from 1 to, at most, we guess, 100 
pages = [*pages_range]
DOMAIN = "http://avaxhome.cc"

while pages.at(0)
  current_page = pages.at(0)
  pages.delete_at(0)

  html_uri_string = "#{DOMAIN}/#{year}/#{month}/#{day}/pages/#{current_page}"
  
  system "/usr/bin/open -a '/Applications/Safari.app' #{html_uri_string}"

  # Wait for a few seconds
  # so that as if this is done by a human
  system "sleep 1"
end
