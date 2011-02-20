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
      begin
        self.parse.to_html.gsub("<<<ROOT_URL>>>",root_url).html_safe
      rescue => e
        #"FFF " + pos_html(genus_html(clean_markup(short_definition)))
        "parsing failed... #{self.definition}"
      end
  end

  def full_html(root_url = "")
    "<span class='writing'><ruby><rb>".html_safe + self.midashigo + "</rb><rp> (</rp><rt>".html_safe + self.kana + "</rt><rp>) </rp></ruby></span> : ".html_safe + self.to_html(root_url)
  end

  alias :short_html :to_html


  def related
    if self.entry_relation["HE"] then
      res = Entry.where(:entry_relation => self.writing + "\n")
    else
      res = Entry.where(:writing => self.entry_relation.strip)
    end
    res || []
  end

  def self.search_by_any(word)
    if word[/[āōīūōA-z]/] then
      Entry.where("definition like ?", "%#{word}%")
    else
      Entry.where("writing like ?", "#{word}%") +
      Entry.where("kana like ?", "#{word}%")
    end
  end 

end
