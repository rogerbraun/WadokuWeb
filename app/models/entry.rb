#encoding: utf-8
class Entry < ActiveRecord::Base

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

end
