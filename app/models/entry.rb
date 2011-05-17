#encoding: utf-8
class Entry < ActiveRecord::Base

  has_many :keywords

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
    if self.first_midashigo == self.cleaned_kana then 
      "<span class='writing'>".html_safe + self.first_midashigo + "</span>".html_safe 
    else "<span class='writing'><ruby><rb>".html_safe + self.first_midashigo + "</rb><rp> (</rp><rt>".html_safe + self.cleaned_kana + "</rt><rp>) </rp></ruby></span> ".html_safe
    end + (rest_midashigo.empty? ? "" : rest_midashigo.join("; ")) + " " + self.to_html(root_url)
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

  def sub_entries
    Entry.where(:entry_relation => self.writing)
  end

  def self.search_by_any(word, page, per_page)
    word = word.to_kana
    ids = Keyword.where("word like ?", "#{word}%").map(&:entry_id)
    Entry.where("id in (?) ", ids).page(page).per(per_page)
  end 

  def first_midashigo
    self.midashigo.split(";").first
  end

  def rest_midashigo 
    self.midashigo.split(";")[1..-1]
  end

  def cleaned_kana
    self.kana[/[^\d\[\]\s]+/]
  end
end
