namespace :db do
  task :fill_index => :environment do
    @count = 0
    pbar = ProgressBar.new("Entries parsed:", Entry.count)
    Entry.transaction do
      Entry.find_each do |entry|
        parts = entry.writing.split(/(?:\[\S+\]|;|\(|\))/).map(&:strip).reject{|x| x == ""}.compact
        parts.each do |part|
          i = Keyword.create(:word => part, :entry_id => entry.id)
        end
        Keyword.create(:word => entry.kana, :entry_id => entry.id)
        pbar.inc
      end
    end
    pbar.finish
  end
end
