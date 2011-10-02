require "pry"
str = open("WaDokuNormal.tab").read

regex = /<([^\s:>]+)>/
arr = []
str.lines.each do |line|
  line.split("\t")[4].scan(regex).each do |match|
    arr << match
  end
end

puts arr.uniq.map{|m| "str('#{m.first}')"}.join(" >> ")
