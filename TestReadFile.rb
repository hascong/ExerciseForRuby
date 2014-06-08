#! /usr/bin/ruby
#encoding: UTF-8

# Input File
system "printf \"The input vocabulary file is: \n\" > test_result_read_file_rb"
system "cat vocab_bank_fake_small >> test_result_read_file_rb"

# Test case 1
system "printf \"\nTest Case 1  The new word is a new head\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb boy \\\"Little boy.\\\"\n\"  >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb boy \"Little boy.\" >> test_result_read_file_rb"

# Test case 2
system "printf \"\nTest Case 2  The new word is behind current head\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb goddd \\\"Goddd.\\\"\n\" >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb goddd \"Goddd.\" >> test_result_read_file_rb"

# Test case 3
system "printf \"\nTest Case 3  The new word is equal to certain entry\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb good \\\"Good to see you again.\\\" \\\"Good night baby.\\\" \\\"Good evening.\\\"\n\" >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb good \"Good to see you again.\" \"Good night baby.\" \"Good evening.\" >> test_result_read_file_rb"

# Test case 4
system "printf \"\nTest Case 4  The new word is behind the middle\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb goooooood \\\"Goooooood.\\\"\n\" >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb goooooood \"Goooooood.\" >> test_result_read_file_rb"

# Test case 5
system "printf \"\nTest Case 5  The new word is before tail\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb hi \\\"Hi there.\\\" \\\"Hi I am John.\\\"\n\" >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb hi \"Hi there.\" \"Hi I am John.\" >> test_result_read_file_rb"

# Test case 6
system "printf \"\nTest Case 6  The new word is behind current tail\n\" >> test_result_read_file_rb"
system "printf \"$ ruby ReadFile.rb zip \\\"Zip!\\\" \\\"Zip up.\\\"\n\" >> test_result_read_file_rb"
system "clear && ruby ReadFile.rb zip \"Zip!\" \"Zip up.\" >> test_result_read_file_rb"
