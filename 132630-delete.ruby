#! /usr/bin/ruby
#encoding: UTF-8

# delete.ruby

require 'net/http' # for Net::HTTP.get()

#
# The amphersand (&) needs to be escaped as \\& when using system call.
# Because the shell would interpret & as "a connector between two shell commands".
# url_string = "https://api.mobileapptracking.com/v2/advertiser/campaigns/urls/delete.json?api_key=2602abbd9bfc6f235b36d8a66a0afb03\\&id="
# system "/usr/bin/open -a '/Applications/Google Chrome.app' #{url_string}#{id_string}"
#

def delete_the_url_whose_id_is(id_value)
  path = "https://api.mobileapptracking.com/v2/advertiser/campaigns/urls/delete.json"
  api_key_value = "ae04e5ad34ae348e0d7ba583e5dbeb8f" # "ae04e5ad34ae348e0d7ba583e5dbeb8f" is Cong Liu's API key in CJ O SHOPPING (20848). 
  url = "#{path}?api_key=#{api_key_value}&id=#{id_value}" 

  html_uri_object = URI(url)
  results_json = Net::HTTP.get(html_uri_object)

  puts id_value + "\n"
  puts results_json + "\n\n"
  # TODO (optional) Log the result of the action for an ID value
end

# Get an ID value
path_id_list = "/Users/congliu/Desktop/zendesk/132630/132630-list_destination_urls_ids_5598"
File.open(path_id_list, 'r') do |file|
  while line = file.gets
    id_value_variable = line

    # Action on an ID value
    delete_the_url_whose_id_is(id_value_variable)

    # Wait for five seconds before next deletion to prevent from being blocked
    sleep(5)
  end 
end
