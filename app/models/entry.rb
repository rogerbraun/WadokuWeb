#encoding: utf-8
class Entry < ActiveRecord::Base

  has_and_belongs_to_many :indexes

  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def parse
    WadokuNewGrammar.parse(self.definition)
  end

  def to_html(root_url = "")
    if not self.parsed then  
      begin 
        self.parse.to_html.gsub("<<<ROOT_URL>>>",root_url).gsub("；","; ").html_safe
      rescue => e
        "Fehler in #{self.definition}"
      end 
    else
      self.parsed.gsub("<<<ROOT_URL>>>",root_url).html_safe
    end
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

  def self.search_by_any(word, page, per_page)
    word = word.to_kana
    Entry.where("writing like ? or kana like ?", "#{word}%", "#{word}%").page(page).per(per_page)
  end 

end
