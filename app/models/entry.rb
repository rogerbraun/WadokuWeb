#encoding: utf-8
class Entry < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30

  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def parse
    WadokuNewGrammar.parse(self.definition)
  end

  def to_html(root_url = "")
    self.parsed.gsub("<<<ROOT_URL>>>",root_url).html_safe
  end

  def full_html(root_url = "")
    "<span class='writing'><ruby><rb>".html_safe + self.midashigo + "</rb><rp> (</rp><rt>".html_safe + self.kana + "</rt><rp>) </rp></ruby></span> : ".html_safe + self.to_html(root_url)
  end

  alias :short_html :to_html

  def related
    if self.entry_relation["HE"] then
      res = Entry.where(:entry_relation => self.writing)
    else
      res = Entry.where(:writing => self.entry_relation.strip)
    end
    res || []
  end

  def self.search_by_any(word)
    if word[/[āōīūōA-z]/] then
      Entry.where("parsed is not null and definition like ?", "%#{word}%")
    else
      Entry.where("parsed is not null and writing like ?", "#{word}%") +
      Entry.where("parsed is not null and kana like ?", "#{word}%")
    end
  end 

end
