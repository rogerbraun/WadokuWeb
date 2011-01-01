# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

source = open("db/source.tab")

puts "Reading source file... This may take a while..."
source.each_line do |line|
  entry_txt = line.split("\t") 

  puts "Something went wrong with:\n #{line}" unless x = Entry.create(:wadoku_id => entry_txt[0], :romaji => entry_txt[1], :writing => entry_txt[2], :kana => entry_txt[3] , :definition => entry_txt[4])

  puts "Wrote #{x.id}..." if x.id % 100 == 0
end
