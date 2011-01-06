namespace :db do
  task :test_parser => :environment do
    @count = 0
    @success = 0
    Entry.all.each do |entry|
      @count +=1
      @success += 1
      begin
        WadokuGrammar.parse(entry.definition)
      rescue => e 
        @success -= 1
      end
        
    end
    puts "#{@count} entries, #{@success} successfully parsed, #{@success.to_f / @count.to_f * 100}% correct."
  end
end
