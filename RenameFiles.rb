#! /usr/bin/ruby
#encoding: UTF-8

puts ""
puts "RenameFiles.rb starts working..."
folderPath = "/Users/congliu/Downloads/"

allOldFileNames = Dir.entries(folderPath).select {|f| !File.directory? f}

allOldFileNames.each do |anOldFileName|
  aNewFileName = anOldFileName.dup
  aNewFileName.gsub!(/ +/, "_")
  if aNewFileName.eql? anOldFileName
  else
    puts "  Renaming a file named \"" + anOldFileName + "\"..."
    puts "  with a new name \"" + aNewFileName + "\"..."
    puts ""
    system "mv \"#{folderPath}#{anOldFileName}\" \"#{folderPath}#{aNewFileName}\""
    # system "sleep 5"
  end
end

puts "RenameFiles.rb gets done the job."
puts "lll"
