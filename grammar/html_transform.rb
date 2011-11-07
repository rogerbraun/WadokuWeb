class HTMLTransform < Parslet::Transform

  rule(:text => simple(:x)) {String.new(x)} 
  rule(:genus => simple(:g), :text => simple(:t)) {"<span class='genus #{g}'>#{g}</span> #{t}"}
  rule(:wrong => simple(:wrong), :genus => simple(:g), :text => simple(:t)) {"<span class='genus #{g}'>#{g}</span> #{wrong + t}"}
  rule(:hw => simple(:hw)) {"<span class='hw'>#{hw}</span>"}
  rule(:emph => simple(:emph)) {"<span class='emph'>#{emph}</span>"}
  rule(:topic => simple(:topic)) {"<span class='topic'>#{topic}</span>"}
  rule(:dom => simple(:dom)) {"<span class='dom'>#{dom}</span>"}
  rule(:transl => simple(:transl)) {"<span class='transl'>#{transl}</span>"}
  rule(:descr => sequence(:contents)) {"<span class='descr'>#{contents.compact.join}</span>"}
  rule(:fore => sequence(:contents)) {"<span class='fore'>#{contents.compact.join}</span>"}
  rule(:pos => sequence(:contents)) {"(<span class='pos'>#{contents.compact.join("")}</span>)" } 
  rule(:tre => sequence(:contents)) {"<span class='tre'>#{contents.compact.join("")}</span>"}
  rule(:mgr => sequence(:contents)) {"<span class='mgr'>#{contents.compact.join("; ")}</span>."} 
  rule(:transcr => sequence(:contents)) {"<span class='transcr'>#{contents.compact.join}</span>"}
  rule(:title => sequence(:contents)) {"<span class='title'>#{contents.compact.join}</span>"}
  rule(:tags_with_parens => sequence(:contents)) do
    contents.compact!
    contents.empty? ? nil :  "(#{contents.join("; ")})" 
  end
  rule(:title_type => simple(:title_type)) {nil}
  rule(:scientif => sequence(:contents)) {"<span class='scientif'>#{contents.compact.join}</span>"}
  rule(:date => simple(:date)) {"<span class='date'>#{date}</span>"}
  rule(:usage => simple(:usage)) {"<span class='usage'>#{usage}</span>"}
  rule(:langniv => simple(:langniv)) {"<span class='langniv'>#{langniv}</span>"}
  rule(:seasonw => simple(:seasonw)) {"<span class='seasonw'>#{seasonw}</span>"}
  rule(:birthdeath => simple(:birthdeath)) {"<span class='birthdeath'>#{birthdeath}</span>"}
  rule(:famn => simple(:famn)) {"<span class='famn'>#{famn}</span>"}
  rule(:expl => sequence(:contents)) {"<span class='expl'>#{contents.compact.join}</span>"}
  rule(:defi=> sequence(:contents)) {"<span class='def'>#{contents.compact.join}</span>"}
  rule(:preamble => sequence(:contents)) {contents.compact.join}
  rule(:fore => sequence(:contents)) {"<span class='for'>#{contents.compact.join}</span>"}
  rule(:etym=> sequence(:contents)) {"<span class='etym'>#{contents.compact.join}</span>"}
  rule(:specchar=> simple(:specchar)) {specchar.to_s}

  rule(:lang => simple(:lang), :keyword => simple(:keyword)) {"Wikipedia: <a href='http://#{lang.to_s.downcase}.wikipedia.org/wiki/#{keyword}'>#{keyword}</a>" }
  rule(:wiki => simple(:wiki)) {"<span class='wiki'>#{wiki}</span>"}

  rule(:audio => simple(:audio)) {nil}
  rule(:unknown => simple(:unknown)) {nil}
  rule(:s_number => simple(:s_number)) {"<a href='http://books.google.com/books?id=bkNWKdYgxVoC&pg=PA#{s_number.to_s}'>S.#{s_number.to_s}</a>"}
  rule(:steinhaus => sequence(:contents)) {"<span class='steinhaus'>Steinhaus: #{contents.compact.join(',')}</span>"}
  rule(:number => simple(:n), :mgr => sequence(:contents)) do
    "<span class='mgr_number'>#{n}</span> <span class='mgr'>#{contents.compact.join("; ")}</span>."
  end

  rule(:number => simple(:n), :dom => simple(:dom), :mgr => sequence(:contents)) do
    "<span class='mgr_number'>#{n}</span> <span class='mgr'><span class='dom'>#{dom}</span> #{contents.compact.join("; ")}</span>."
  end
  rule(:number => simple(:n), :tags_with_parens => sequence(:tags_content), :mgr => sequence(:contents)) do
    tags_content.compact!
    "<span class='mgr_number'>#{n}</span> <span class='mgr'>#{tags_content.empty? ? '' : "(#{tags_content.join("; ")})"} #{contents.compact.join("; ")}</span>."
  end

  rule(:wrong_number => simple(:n), :mgr => sequence(:contents)) do
    "<span class='mgr_number'>#{n.to_s[/\d+/]}</span> <span class='mgr'>#{contents.compact.join("; ")}</span>."
  end

  rule(:thing => simple(:thing)){ "[#{thing}]" }
  rule(:thing => simple(:thing), :tags_with_parens => sequence(:contents)){ "[#{thing}] (#{contents.compact.join("; ")})" }

  rule(:marker => simple(:n)) {nil}
  rule(:jwd => simple(:jwd)) {nil}

  rule(:url => simple(:url)) {"<a href='#{url}'>#{url}</a>"}


  rule(:pict => subtree(:x)) { nil }

  rule(:transcr => sequence(:t_content), :jap => simple(:jap), :daid => simple(:d)) do
    "<span class='ref'><a href='/entries/by-daid/#{d}'><span class='jap'>#{jap}</span> - <span class='transcr'>#{t_content.compact.join}</span></a></span>"  
  end

  rule(:jap => simple(:jap)) {"<span class='jap'>#{jap}</span>"}

  rule(:impli => simple(:impli)) {"<span class='impli'>#{impli}</span>"}
  rule(:expli => sequence(:content)){" <span class='expli'>#{content.compact.join}</span>"}
  rule(:literal => sequence(:content)){" <span class='literal'>#{content.compact.join}</span>"}

  rule(:relation => simple(:relation), :transcr => sequence(:t_content), :jap => simple(:jap), :daid => simple(:d)) do
    "<span class='ref'><span class='relation'>#{relation}</span><a href='/entries/by-daid/#{d}'><span class='jap'>#{jap}</span> - <span class='transcr'>#{t_content.compact.join}</span></a></span>"  
  end


  rule(:numbered_mgr => simple(:numbered_mgr)) {"<span class='numbered_mgr'>#{numbered_mgr}</span>" }

  rule(:full_entry => sequence(:contents)) do
    res = contents.compact.join(" ")
    res += "." unless res[/\.(<\/span>)*$/]
    res
  end

  
  # drop it.
  rule(:seperator => simple(:seperator)){nil}
end

