#encoding: utf-8
class Entry < ActiveRecord::Base
  include ActionView::Helpers
  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def parse
    @parse ||= WadokuGrammar.new.parse(self.definition)
  end


  def related
    if self.entry_relation["HE"] then
      res = Entry.where(:entry_relation => self.writing)
    else
      res = Entry.where(:writing => self.entry_relation.strip)
    end
    res || []
  end

  def sub_entries
    Entry.where(:entry_relation => self.writing)
  end


  # This is to change the result of the to_html result. Nothing should implemented here, but it may be for
  # a quick fix.
  def hacks(ready_html)

    res = ready_html.scan(/(.*)(<span class='svg_image'>.*?<\/a><\/span><\/span>)(.*)/).first

    return ready_html unless res
    
    [res[0], res[2], res[1]].join("").html_safe
   
  end
end
