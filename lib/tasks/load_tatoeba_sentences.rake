namespace :db do
  task :load_tatoeba_sentences => :environment do
    tatoeba_sentences = open("db/sentences.csv")
    tatoeba_sentences.each_line do |line|
      parts = line.split("\t")
      print  "."
      if parts[1] == "deu" or parts[1] == "jpn" then
        puts "something went wrong when trying to write:\n#{line}" unless ExSentence.create(:id => parts[0], :lang => parts[1], :content => parts[2]) 
      end
    end

    links = open("db/sentences.csv")
    links.each_line do |line|
      parts = line.split("\t")
      s = ExSentence.find(parts[0])
      t = ExSentence.find(parts[1])
      if s and t then
        s.translations << t
        s.save
      else
        puts "Something went wrong when adding #{parts}"
      end
      print "." 
    end
  end
end
