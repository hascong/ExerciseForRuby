#! /usr/bin/ruby
#encoding: UTF-8

threeSeconds = 3
thirtySeconds = 30
oneMinute = 60
twoMinutes = oneMinute * 2
oneHour = oneMinute * 60
twoHours = oneHour * 2
threeHours = oneHour * 3
fourHours = oneHour * 4
eightHours = oneHour * 8
tenHours = oneHour * 10
twelveHours = oneHour * 12
twentyFourHours = oneHour * 24
delayBeforeTaskOne = fourHours
delayBetweenTaskOneAndTwo = tenHours

system "sleep #{delayBeforeTaskOne}"

system "osascript ~/Desktop/taskOne.scpt"

system "sleep #{delayBetweenTaskOneAndTwo}"

system "osascript ~/Desktop/taskTwo.scpt"
