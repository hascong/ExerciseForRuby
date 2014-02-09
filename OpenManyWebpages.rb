#! /usr/bin/ruby

require 'net/http' # to get html source

# inputs
year = "2014" # 2014
month = "02" # 01..12, 02 stands for Feb
day = "01" # 01..31
pages_range = 1..100 # page ranges from 1 to, at most, we guess, 100 
pages = [*pages_range]
DOMAIN = "http://avaxhome.cc"

while pages.at(0)
  current_page = pages.at(0)
  pages.delete_at(0)

  # todo: to be generated from given input of dates and ranges
  html_uri_string = "#{DOMAIN}/#{year}/#{month}/#{day}/pages/#{current_page}"
  html_uri_object = URI(html_uri_string)
  html_source_string = Net::HTTP.get(html_uri_object)
  # puts "html source string:\n#{html_source_string}" # debug
  
  # e.g. /ebooks/cooking_diets/0761146407.html
  items_in_current_page = html_source_string.scan(/\/(?:ebooks|magazines|newspapers)\/[^\s"]+/).uniq
  # puts items_in_current_page # debug
  
  # While there is a new item in current page, e.g., ebooks, magazines or newspapers
  while items_in_current_page.at(0)
    # e.g. 'http://avaxhome.cc/ebooks/science_books/psychology_behavior/04957962120.html'
    url_stub = items_in_current_page.at(0)
    items_in_current_page.delete_at(0)
    html_uri_string_item = "#{DOMAIN}#{url_stub.to_s}"
    # html_uri_string_item = "http://avaxhome.cc/ebooks/ingrid-noll-hab-und-gier.html" # debug
    # puts html_uri_string_item # debug

    html_uri_item = URI(html_uri_string_item)
    html_source_item = Net::HTTP.get(html_uri_item)
      
    # e.g. 'http://k2s.cc/file/52ed1ba754a01/0495796212.pdf'
    #      'http://filepost.com/files/89mmeacd/Marvel_Universe_-_Avengers_Earth_s_Mightiest_Heroes_010_(2013)_(c2c)_(PeteThePIPster).cbz/'
    #      'http://ul.to/mmp20ooz'
    download_address_strings = html_source_item.scan(/https?:\/\/(?:k2s\.cc|filepost\.com|uploaded\.net|ul\.to)[^\s"]+/).uniq
    while download_address_strings.at(0)
      current_download_address_string = download_address_strings.at(0)
      download_address_strings.delete_at(0)

      # Modify download link
      # for links from uploaded.net or ul.to
      regex_uploaded_net = /(uploaded\.net|ul\.to)/
      if (regex_uploaded_net.match current_download_address_string)
        # todo: (1) solve redirect problem
        #   Net::HTTP.get cannot handle "http://ul.to/mmp20ooz", but can handle "http://uploaded.net/file/mmp20ooz"
        # todo: (2) solve cookie problem
        #   Even if "http://uploaded.net/file/mmp20ooz" is open, the status is not logged in
        uploaded_html_uri_object = URI(current_download_address_string)
        uploaded_html_source_string = Net::HTTP.get(uploaded_html_uri_object)
        # puts "uploaded html source string:\n#{uploaded_html_source_string}" # debug
        
        premium_download_button_address_regex = /action=\"https?:\/\/[^\s"]+uploaded\.net[^\s"]+\"/
        current_download_address_string = uploaded_html_source_string.scan(premium_download_button_address_regex).uniq.at(0)
        # puts "This is the final download link: #{current_download_address_string}" # debug
      else
        # Run download link in Google Chrome
        # to start download automatically
        # for files from k2s.cc and filepost.com
        puts current_download_address_string
        system "/usr/bin/open -a '/Applications/Google Chrome.app' #{current_download_address_string}"

        # Wait for three seconds
        # so that as if this is done by a human
        system "sleep 3"
      end
    end
  end
end
