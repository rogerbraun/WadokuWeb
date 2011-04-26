namespace :db do
  task :fill_index => :environment do
    @count = 0
    pbar = ProgressBar.new("Entries parsed:", Entry.count)
    to_insert = []
    Entry.find_each do |entry|
      parts = entry.writing.split(/(?:\[\S+\]|;|\(|\))/).map(&:strip).reject{|x| x == ""}.compact
      parts.each do |part|
        str = ""
        part.each_char do |c|
          str << c
          i = Index.create(:query => str)
          to_insert << "(#{entry.id}, #{i.id})"
        end
      end
      entry.save
      @count +=1
      pbar.inc
    end
    Index.connection.execute "insert into entries_indices ('entry_id', 'index_id') values #{to_insert.join(", ")}"
    pbar.finish
  end
end
