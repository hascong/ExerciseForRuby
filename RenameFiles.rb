#! /usr/bin/ruby
#encoding: UTF-8

puts "RenameFiles.rb starts working..."
folderPath = "/Users/congliu/Downloads/"

allOldFileNames = Dir.entries(folderPath).select {|f| !File.directory? f}

allOldFileNames.each do |anOldFileName|
  puts "  Trying to rename a file with an old file name \"" + anOldFileName + "\""
  aNewFileName = anOldFileName.dup
  # Replace all spaces with underscore
  aNewFileName.gsub!(/ +/, "_")
  puts "  Rename it as \"" + aNewFileName + "\""
  puts ""
  if aNewFileName.eql? anOldFileName 
  else
    system "mv \"#{folderPath}#{anOldFileName}\" \"#{folderPath}#{aNewFileName}\""
    system "sleep 5"
  end
end

puts "RenameFiles.rb gets job done."
