# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
source = open("db/WaDokuNormal.tab").read

puts "Reading source file... This may take a while..."

pbar = ProgressBar.new("Indexing...:", source.lines.count)
Entry.transaction do
  source.each_line do |line|
    entry_txt = line.split("\t") 

    Entry.create(:wadoku_id => entry_txt[0], :midashigo => (entry_txt[2] == "") ? entry_txt[1] : entry_txt[2], :writing => entry_txt[1], :kana => entry_txt[3] , :definition => entry_txt[4], :entry_relation => entry_txt[8])

    pbar.inc
  end
end
pbar.finish
