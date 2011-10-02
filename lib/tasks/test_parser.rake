namespace :db do
  task :test_parser => :environment do
    @count = 0
    @success = 0
    @entries = open(File.join(Rails.root, "db", "WaDokuNormal.tab")).readlines
    pbar = ProgressBar.new("Entries parsed:", @entries.count)
    failed = []
    ActiveRecord::Base.transaction do
      @entries.each do |entry|
        @count +=1
        @success += 1
        defi = entry.split("\t")[4]
        pbar.inc
        begin
          WadokuNewGrammar.parse(defi)
        rescue => e 
          @success -= 1
          failed << defi
        end
      end
    end
    pbar.finish
    puts "#{@count} entries, #{@success} successfully parsed, #{@count - @success} not parsed. (#{@success.to_f / @count.to_f * 100}%)"
    puts "wrote failed entries to log/failed.log"
    open(File.join(Rails.root, "log", "failed.log"), "w").write(failed.join("\n"))
  end
end
