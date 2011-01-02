class Entry < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  def short_definition
    self.defs_array.first + (self.defs_array.size > 1 ? "...": "")
  end

  def short_html
    pos_html(genus_html(short_definition))
  end

  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def defs_array
    p = self.definition
    t = p.scan(/\[(\d+)\]([^[]+)/).map{|x| x[1].strip}
    t.empty? || t == nil ? [p] : t
  end

  def related
    if self.entry_relation["HE"] then
      res = Entry.where(:entry_relation => self.writing + "\n")
    else
      res = Entry.where(:writing => self.entry_relation.strip)
    end
    res || []
  end

  private

  CLEAN_REGEXPS = [/\{<.+?>\}/]

  def pos_and_def
    self.definition.match(/^(\(.+?\))(.*)/)[1..-1] 
  end

  def genus_html(defi)
    defi.gsub(/<Gen.: (\w+)>/) do |mat|
      " <em>#{$1}</em>"
    end
  end

  def pos_html(defi)
    defi.gsub(/\(<POS: (\w+).>\)/) do |mat|
      " <strong>#{$1}</strong>"
    end
  end

end
