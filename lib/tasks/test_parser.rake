namespace :db do
  task :test_parser => :environment do
    @count = 0
    @success = 0
    @entries = Entry.all
    pbar = ProgressBar.new("Entries parsed:", @entries.count)
    @entries.each do |entry|
      @count +=1
      @success += 1
      pbar.inc
      begin
        WadokuNewGrammar.parse(entry.definition)
      rescue => e 
        @success -= 1
      end
    end
    pbar.finish
    puts "#{@count} entries, #{@success} successfully parsed, #{@success.to_f / @count.to_f * 100}% correct."
  end
end
