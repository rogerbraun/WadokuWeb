#encoding: utf-8
class Entry < ActiveRecord::Base

  has_paper_trail

  def parse
    @parse ||= WadokuGrammar.new.parse(self.definition)
  end
    
  def head_entry
    unless self.entry_relation["HE"] then
      Entry.find_by_wrting(self.entry_relation.strip)
    end
  end

  def sub_entries
    Entry.where(:entry_relation => self.writing)
  end

  def self.search_with_picky(q, options)
    res = EntrySearch.search q, options
    res.extend Picky::Convenience
    entries = res.ids.map{|id| Entry.find_by_wadoku_id(id)}.compact.uniq
    entries
  end

  def self.search_for_headwords(q, max)
    entries = search_with_picky q, ids: 30, offset: 0
    only_headwords = entries.map{|entry| 
      begin 
        entry.parse.subtree(:hw)
      rescue
        nil
      end
      }.compact.flatten
    only_text = only_headwords.map{|hw| hw.subtree(:text)}.flatten
    array = only_text.map(&:values).flatten.map(&:to_s).uniq
    array[0..max]
  end

  def self.search_for_tres(q, max)
    entries = search_with_picky q, ids: 30, offset: 0
    only_tres = entries.map{|entry| 
      begin
        entry.parse.subtree(:tre)
      rescue
        nil
      end
      }.compact.flatten
    array = only_tres.map{|x| x.subtree(:text).map(&:values).join("")}
    array[0..max]
  end
end
