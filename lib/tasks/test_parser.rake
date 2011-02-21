namespace :db do
  task :test_parser => :environment do
    @count = 0
    @success = 0
    @entries = Entry
    pbar = ProgressBar.new("Entries parsed:", @entries.count)
    failed= []
    Entry.find_each do |entry|
      @count +=1
      @success += 1
      pbar.inc
      begin
        WadokuNewGrammar.parse(entry.definition)
      rescue => e 
        @success -= 1
        failed << entry.definition
      end
    end
    pbar.finish
    puts "#{@count} entries, #{@success} successfully parsed, #{@count - @success} not parsed. (#{@success.to_f / @count.to_f * 100}%)"
    puts "wrote failed entries to log/failed.log"
    open(File.join(Rails.root, "log", "failed.log"), "w").write(failed.join("\n"))
  end
end
