#! /usr/bin/ruby
#encoding: UTF-8

folderPath = "/Users/congliu/Desktop/test/"

allOldFileNames = Dir.entries(folderPath).select {|f| !File.directory? f}

allOldFileNames.each do |anOldFileName|
  puts anOldFileName
  aNewFileName = anOldFileName
  aNewFileName.gsub(/ +/, "_")
  puts aNewFileName
  # system "mv #{folderPath}#{anOldFileName} #{folderPath}#{aNewFileName}"
end
