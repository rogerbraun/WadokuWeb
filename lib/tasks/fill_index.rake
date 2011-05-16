namespace :db do
  task :fill_index => :environment do
    pbar = ProgressBar.new("Indexing...:", Entry.count)
    Entry.transaction do
      Entry.find_each do |entry|
        parts = entry.writing.split(/(?:\[\S+\]|;|\(|\))/).map(&:strip).reject{|x| x == ""}.compact 
        parts << entry.kana
        parts.uniq!
        parts.each do |part|
          i = Keyword.create(:word => part, :entry_id => entry.id)
        end
        pbar.inc
      end
    end
    pbar.finish
  end
end
