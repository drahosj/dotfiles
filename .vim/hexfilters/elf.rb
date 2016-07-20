#! /usr/bin/env ruby

# Doc definitions
doc_32 = <<DOC.split "\n"
        |                 IDENT                 |
        |type|mach| version |  entry  |  phoff  |
        |  shoff  |  flags  |ehsz|pesz|pnum|sesz|
        |snum|stri|        data/padding         |
DOC

doc_64 = <<DOC.split "\n"
        |                 IDENT                 |
        |type|mach| version |       entry       |
        |       phoff       |       shoff       |
        |  flags  |ehsz|pesz|pnum|sesz|snum|stri|
DOC

# Grab the lines of the header
header = []
4.times do |i|
  header[i] = gets
end


type = header[0].match(/\d+: [[:xdigit:] ]{9} ([[:xdigit:]]{2})/)[1]
case type
when "01" then
  doc = doc_32
when "02" then
  doc = doc_64
else
  puts "ERROR: UNKNOWN ELF CLASS"
  return -1
end

doc.zip(header).each do |d, h|
  puts d
  print h
end

STDIN.readlines.each {|l| puts l}
