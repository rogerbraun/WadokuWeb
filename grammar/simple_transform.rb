class SimpleTransform < Parslet::Transform

  rule(:text => simple(:x)) {String.new(x)} 
  rule(:genus => simple(:g), :text => simple(:t)) {"#{t} (#{g})"}
  rule(:wrong => simple(:wrong), :genus => simple(:g), :text => simple(:t)) {"#{wrong + t} (#{g})"}
  rule(:hw => simple(:hw)) {"#{hw}"}
  rule(:emph => simple(:emph)) {"#{emph}"}
  rule(:topic => simple(:topic)) {"#{topic}"}
  rule(:dom => simple(:dom)) {"{#{dom}]"}
  rule(:transl => simple(:transl)) {"#{transl}"}
  rule(:descr => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:fore => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:pos => sequence(:contents)) {"(#{contents.compact.join("")})" } 
  rule(:tre => sequence(:contents)) {"#{contents.compact.join("")}"}
  rule(:mgr => sequence(:contents)) {"#{contents.compact.join("; ")}."} 
  rule(:transcr => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:title => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:tags_with_parens => sequence(:contents)) do
    contents.compact!
    contents.empty? ? nil :  "(#{contents.join("; ")})" 
  end
  rule(:title_type => simple(:title_type)) {nil}
  rule(:scientif => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:date => simple(:date)) {"#{date}"}
  rule(:usage => simple(:usage)) {"#{usage}"}
  rule(:langniv => simple(:langniv)) {"#{langniv}"}
  rule(:seasonw => simple(:seasonw)) {"#{seasonw}"}
  rule(:birthdeath => simple(:birthdeath)) {"#{birthdeath}"}
  rule(:famn => simple(:famn)) {"#{famn}"}
  rule(:expl => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:defi=> sequence(:contents)) {"#{contents.compact.join}"}
  rule(:preamble => sequence(:contents)) {contents.compact.join}
  rule(:fore => sequence(:contents)) {"#{contents.compact.join}"}
  rule(:etym=> sequence(:contents)) {"#{contents.compact.join}"}
  rule(:specchar=> simple(:specchar)) {specchar.to_s}

  rule(:lang => simple(:lang), :keyword => simple(:keyword)) {nil}
  rule(:wiki => simple(:wiki)) {nil}

  rule(:audio => simple(:audio)) {nil}
  rule(:unknown => simple(:unknown)) {nil}
  rule(:s_number => simple(:s_number)) {nil}
  rule(:steinhaus => sequence(:contents)) {nil}
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

