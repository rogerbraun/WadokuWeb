namespace :db do
  task :test_failed=> :environment do
    @count = 0
    @success = 0
    file = open(File.join(Rails.root, "log", "failed.log"))
    @entries = file.readlines
    file.close
    file = open(File.join(Rails.root, "log", "failed.log"), "w")
    pbar = ProgressBar.new("Entries parsed:", @entries.count)
    failed = []
    ActiveRecord::Base.transaction do
      @entries.each do |entry|
        @count +=1
        @success += 1
        defi = entry
        pbar.inc
        begin
          WadokuNewGrammar.parse(defi)
        rescue => e 
          @success -= 1
          failed << defi
          file.puts defi
        end
      end
    end
    pbar.finish
    puts "#{@count} entries, #{@success} successfully parsed, #{@count - @success} not parsed. (#{@success.to_f / @count.to_f * 100}%)"
    puts "wrote failed entries to log/failed.log"
  end
end
