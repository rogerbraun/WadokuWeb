namespace :entries do
  task :pre_parse => :environment do
    pbar = ProgressBar.new("Indexing...:", Entry.count)
    transformer = HTMLTransform.new
    wadokugrammar = WadokuGrammar.new
    
    Entry.find_each do |entry|
      Entry.transaction do
        begin
          out = transformer.apply(wadokugrammar.parse(entry.definition))
        rescue => e
          out = entry.definition
        end
        entry.parsed = out
        entry.save
        pbar.inc
      end
    end
    pbar.finish
  end

  task :clean_pre_parsed => :environment do
    Entry.update_all(:parsed => nil)
  end
end
