#encoding: utf-8
class Entry < ActiveRecord::Base
  include ActionView::Helpers
  def pos
    self.definition.match(/POS: (.)/)[1]
  end

  def parse
    WadokuNewGrammar.parse(self.definition)
  end


  def to_html(root_url = "")
    begin 
      res = self.parse.to_html.gsub("<<<ROOT_URL>>>",root_url).gsub("；","; ").html_safe
    rescue => e
      res = "Fehler in #{self.definition}"
    end 
    
    self.hacks(res)
  end

  def full_html(root_url = "")
    if self.first_midashigo == self.cleaned_kana then 
      "<span class='writing'>".html_safe + self.first_midashigo + "</span>".html_safe 
    else "<span class='writing'><ruby><rb>".html_safe + self.first_midashigo + "</rb><rp> (</rp><rt>".html_safe + self.cleaned_kana + "</rt><rp>) </rp></ruby></span> ".html_safe
    end + audio_tag + (rest_midashigo.empty? ? "" : rest_midashigo.join("; ")) + " " + self.to_html(root_url) 
  end

  def audio_tag
    if parse.audio_file then
      ("<span class='pron_audio'>" + link_to(t("pronounciation", :default => "Aussprache"), "/audio/#{parse.audio_file}.mp3") + "</span>").html_safe
    else
      ""
    end
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

  def first_midashigo
    self.midashigo.split(";").first
  end

  def rest_midashigo 
    self.midashigo.split(";")[1..-1]
  end

  def cleaned_kana
    self.kana[/[^\d\[\]\s]+/]
  end

  # This is to change the result of the to_html result. Nothing should implemented here, but it may be for
  # a quick fix.
  def hacks(ready_html)

    res = ready_html.scan(/(.*)(<span class='svg_image'>.*?<\/a><\/span><\/span>)(.*)/).first

    return ready_html unless res
    
    [res[0], res[2], res[1]].join("").html_safe
   
  end
end
