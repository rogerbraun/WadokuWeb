class Entry < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  def short_definition
    self.defs_array.first + (self.defs_array.size > 1 ? "...": "")
  end


  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def defs_array
    p = pos_and_def[1]
    t = p.scan(/\[(\d+)\]([^[]+)/).map{|x| x[1].strip}
    t.empty? || t == nil ? [p] : t
  end

  private

  def pos_and_def
    self.definition.match(/^(\(.+?\))(.*)/)[1..-1]
  end

end
