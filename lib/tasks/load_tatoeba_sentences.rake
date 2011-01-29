namespace :db do
  task :load_tatoeba_sentences => :environment do
    tatoeba_sentences = open("db/sentences.csv").read.split("\n")
    tatoeba_sentences.each do |line|
      parts = line.split("\t")
      if parts[1] == "deu" or parts[1] == "jpn" then
        print  "."
        puts "something went wrong when trying to write:\n#{line}" unless ExSentence.create(:tatoeba_id => parts[0], :lang => parts[1], :content => parts[2]) 
      end
    end

    links = open("db/links.csv").read.split("\n")
    links.each do |line|
      parts = line.split("\t")
      s = ExSentence.find_by_tatoeba_id(parts[0])
      t = ExSentence.find_by_tatoeba_id(parts[1])
      if s and t then
        s.translations << t
        s.save
        print "." 
      else
        puts "Something went wrong when adding #{parts}"
      end
    end
  end
end
