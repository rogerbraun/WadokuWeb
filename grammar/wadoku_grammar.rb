#encoding: utf-8
require "parslet/convenience"

class WadokuGrammar < Parslet::Parser

# (POS)
  #rule(:pos) { (str("(<POS:") >> space? >> match('[^,>]').repeat(1).as(:main_pos) >> secondary_pos? >> str(">)")).as(:pos)}
  rule(:pos) {(str("(<POS:") >> space? >> pos_content.repeat(1) >> space? >> str(">)")).as(:pos)}
  rule(:pos_content) { text | transcr | expl | space } 
  #rule(:secondary_pos){(str(",") >> space? >> pos_content.repeat(1) >> space?).as(:secondary_pos)}
  #rule(:secondary_pos?) {secondary_pos.maybe}
  rule(:pos?) { pos.maybe }

# <Ref>
  rule(:ref) { str("<Ref.:") >> space? >> relation_symbol? >> space? >> transcr >> space? >> jap >> space? >> daid >> space? >> str(">")}

  rule(:transcr) { (str("<Transcr.:") >> space? >> transcr_content.repeat(1) >> space? >> str(">")).as(:transcr)}
  rule(:transcr_content) {text | emph}

  rule(:jap) { str("<Jap.:") >> space? >> non_closing.as(:jap) >> space? >> str(">")}
  rule(:daid) { str("<DaID:") >> space? >> non_closing.as(:daid) >> space? >> str(">")}
  rule(:steinhaus) { (str("<Steinhaus:") >> space? >> (s_number | str(",") | space).repeat(1) >> space? >> str(">")).as(:steinhaus)}
  rule(:s_number) { match('[\d]').repeat(1).as(:s_number) }

  rule(:url){ str("<URL:") >> space? >> match('[^>]').repeat(1).as(:url) >> str(">")}

# <Date>

  rule(:date) {str("<Date:") >> space? >> non_closing.as(:date) >> space? >> str(">")}

# <Pict>

  rule(:pict) { (str("<Pict.:") >> space? >> capt >> space? >> filen >> str(">")).as(:pict) }
  rule(:capt) { str("<Capt.:") >> space? >> non_closing.as(:capt) >> space? >> str(">") }
  rule(:filen) { str("<FileN:") >> space? >> non_closing.as(:filen) >> space? >> str(">") }

# <HW>

  rule(:hw) { (str("<HW") >> space? >> non_closing.as(:genus) >> space? >> str(":") >> space? >> hw_content.repeat(1) >> space? >> str(">")).as(:hw) }
  rule(:wrong_hw) { (str("<") >> non_hw_non_closing.as(:wrong) >> str("HW") >> space? >> non_closing.as(:genus) >> space? >> str(":") >> space? >> non_closing.as(:text) >> space? >> str(">")).as(:hw) }
  rule(:non_hw_non_closing) { match("[^>:HW]").repeat(1) }

  rule(:hw_content) {emph | text}

# <Title>

  rule(:title) { (str("<Title") >> space? >> non_closing.maybe.as(:title_type) >> space? >> str(":") >> space? >> title_content.repeat(1) >> space? >> str(">")).as(:title) }
  rule(:title_content) { text | hw}
#<SpecChar><SpecChar.: &>

  rule(:specchar) { str("<SpecChar.:") >> space? >> non_closing.as(:specchar) >> space? >> str(">")}

# <Expl>

  rule(:expl) { (str("<Expl.:") >> space? >> expl_content.repeat(1) >> space? >> str(">")).as(:expl) }
  rule(:expl_content) { transcr | topic | transl | literal | text | ref | title | fore | emph | jap }

# <Etym>

  rule(:etym) { (str("<Etym.:") >> space? >> etym_content.repeat(1) >> space? >> str(">")).as(:etym)}
  rule(:etym_content) { text | ref | fore | impli | expli | transl | topic | transcr}

# JCVD

  rule(:jwd) { str('<JWD:') >> space? >> match('[\d]').repeat(1).as(:jwd) >> space? >> str('>')}
# <literal>

  rule(:literal) {(str("<literal:") >> space? >> literal_content.repeat(1) >> space? >> str(">")).as(:literal) }
  rule(:literal_content) { hw | text}

# <Topic>

  rule(:topic) {str("<Topic:") >> space? >> non_closing.as(:topic) >> space? >> str(">") }

# <Transl>

  rule(:transl) {str("<Transl.:") >> space? >> non_closing.as(:transl) >> space? >> str(">") }

# <Def>

  rule(:defi) { (str("<Def.:") >> space? >> defi_content.repeat(1) >> space? >> str(">")).as(:defi) }
  rule(:defi_content) { iron | topic | transl | literal | text | birthdeath | hw | ref | title| transcr}

# <Usage>

  rule(:usage) { str("<Usage:") >> space? >> non_closing.as(:usage) >> space? >> str(">") }

#<Audio>

  rule(:audio) { str("<Audio:") >> space? >> text.as(:audio) >> space? >> str(">")}

# {<Dom>}

  rule(:dom) { str("{<Dom.:") >> space? >> non_closing.as(:dom) >> space? >> str(">}") }
  rule(:dom?) { dom.maybe }

# <FamN>

  rule(:famn) {str("<FamN.") >> space? >> str("Ausn.").maybe >> space? >> str("L_JPN").maybe  >> space? >> str(":") >> space? >> non_closing.as(:famn) >> space? >> str(">")}

# <Descr.:>

  rule(:descr) { (str("<Descr.:") >> space? >> descr_content.repeat(1)  >> space? >> str(">")).as(:descr)}
  rule(:descr_content) { text | transcr }

#<BirthDeath: 1883–1971>

  rule(:birthdeath) { (str("<BirthDeath:") | str("<BirthDeath.:")) >> space? >> non_closing.as(:birthdeath) >> space? >> str(">")}

#<For.: <Emph.:A>gentstwo <Emph.:S>owjet <Emph.:N>jus>

  rule(:fore) {(str("<For.:") >> space? >> fore_content.repeat(1) >> space? >> str(">")).as(:fore)}
  rule(:fore_content) { text | emph | transl | fore}

#<Emph>

  rule(:emph) {str("<Emph.:") >> space? >> non_closing.as(:emph) >> space? >> str(">") }

#<Scientif.:>

  rule(:scientif) { (str("<Scientif.:") >> space? >> scientif_content.repeat(1) >> space? >> str(">")).as(:scientif) }
  rule(:scientif_content) { text | hw }

#<impli.:>:w
#    text = "(<POS: N.>) <MGr: {<Dom.: Archit.>} <TrE: <HW m: Architrav>>; <TrE: <HW n: Epistylion>>> (<Def.: auf einer Säulenreihe ruhender tragender Querbalken>；<Etym.: <impli.: aus d. Engl.><expli.: von engl. <For.: architrave>>>；<Ref.: ☞ <Transcr.: ākitorēbu> <Jap.: アーキトレーブ><DaID: 9025857>>)."

  rule(:impli) {str("<impli.:") >> space? >> non_closing.as(:impli) >> space? >> str(">") }

#<expli>

  rule(:expli) { (str("<expli.:") >> space? >> expli_content.repeat(1) >> space? >> str(">")).as(:expli) }
  rule(:expli_content) {text | fore }

#<LangNiv>

  rule(:langniv) { str("<LangNiv.:") >> space? >> non_closing.as(:langniv) >> space? >> str(">")}

#<SeasonW>

  rule(:seasonw) {str("<SeasonW.:") >> space? >> non_closing.as(:seasonw) >> space? >> str(">")}
 
# Tags in parentheses

  rule(:tags_with_parens) {(str("(") >> space? >> parens_content.repeat(1) >> space? >> str(")")).as(:tags_with_parens)}

  rule(:parens_content) {usage | defi | expl | pict | audio | ref | descr | seperator | space | etym | birthdeath | langniv | scientif | seasonw | date | steinhaus | url | jwd | wiki }

  rule(:tags_with_parens?) { tags_with_parens.maybe}

# Wikilinks

  rule(:wiki) {(str("<Wiki") >> match(".").repeat(2,2).as(:lang) >> space? >> str(":") >> space? >> non_closing.as(:keyword) >> space? >> str(">")).as(:wiki)}

# <iron.>
  rule(:iron) { (str("<iron.:") >> space? >> iron_content.repeat(1) >> space? >> str(">")).as(:iron) }

  rule(:iron_content) { hw | text}

# <TrE>

  rule(:tre) { (str("<TrE:") >> space? >> tre_content.repeat(1) >> space? >> str(">")).as(:tre) }

  rule(:tre_content) { fore | iron | dom | tags_with_parens | transl | topic | hw | wrong_hw | defi | text | marker | jap | famn | specchar | title | scientif | emph | literal | unknown }

# <MGr>

  rule(:mgr) { (str("<MGr:") >> space? >> mgr_content.repeat(1) >> space? >> str(">")).as(:mgr) }
  rule(:mgr_content) { dom | tre | tags_with_parens | seperator | defi | space}

# [x]<MGr>

  rule(:numbered_mgr) {((number | wrong_number) >> space? >> dom.maybe >> space? >> tags_with_parens.maybe >> space? >> mgr).as(:numbered_mgr)}

# All kinds of MGr
# Tags in parentheses should probably not be here.
  rule(:any_mgr) {numbered_mgr | tags_with_parens | mgr | seperator | space}

# Any unknown tag

  rule(:unknown) { str("<") >> non_closing.repeat(1).as(:unknown) >> str(">")}

# All the markers

  rule(:marker) { 
#(str('Prior_1') | str('JLPT2') | str('Prior_4') | str('GENKI_L14-II') | str('GENKI_K4') | str('GENKI_K22') | str('GENKI_K21') | str('GENKI_L11-II') | str('GENKI_K10') | str('GENKI_K14') | str('GENKI_K18') | str('GENKI_K6') | str('GENKI_L14') | str('GENKI_K3') | str('GENKI_K2') | str('GENKI_K7–s–') | str('GENKI_K5') | str('GENKI_K20') | str('GENKI_K16') | str('GENKI_K1') | str('GENKI_K7') | str('GENKI_L20-II') | str('GENKI_K12') | str('GENKI_L12-II') | str('GENKI_K13') | str('GENKI_K8') | str('GENKI_L23-II') | str('GENKI_L8-II') | str('会G') | str('MiWB') | str('GrWB') | str('SpezWB') | str('GENKI_K9') | str('GENKI_L10-II') | str('GENKI_L19-II') | str('GENKI_L16-II') | str('GENKI_K2–s–') | str('GENKI_K4 _s_') | str('GENKI_K4–s–') | str('GENKI_L21-II') | str('GENKI_L19') | str('GENKI_K19') | str('GENKI_L9') | str('GENKI_L22-II') | str('GENKI_L15-II') | str('GENKI_K17') | str('GENKI_K15') | str('GENKI_K10–s–') | str('GENKI_K11') | str('GENKI_K7 _s_') | str('rsam') | str('GENKI_K23') | str('JWD0512706') | str('JWD0514095') | str('JWD0523511') | str('JWD0034270') | str('JWD0547674') | str('GENKI_K10 _s_') | str('GENKI_K5–s–') | str('GENKI_L17-II') | str('GENKI_K11 _s_') | str('GENKI_K17 _s_') | str('GENKI_L18-II') | str('GENKI_K17–s–') | str('GENKI_K12 _s_') | str('GENKI_K9 _s_') | str('GENKI_K6 _s_') | str('GENKI_K9–s–') | str('GENKI_K13–s–') | str('GENKI_L13-II') | str('GENKI_K5 _s_') | str('GENKI_L19-III') | str('<JLPT2') | str('GENKI_L9-II') | str('GENKI_K1–s–') | str('GENKI_K12–s–') | str('GENKI_L5-II') | str('GENKI_K15–s–') | str('Prior_3') | str('WBGes') | str('GENKI_K15 _s_') | str('JWD0058918') | str('JWD0001109') | str('GENKI_K13 _s_') | str('JWD0216734') | str('GENKI_K1 _s_') | str('GENKI_L18-III') | str('GENKI_L13-III') | str('GENKI_K6–s–') | str('Gen<JLPT2') | str('JWD0304286') | str('JWD0221300') | str('JWD0221299') | str('nonrev') | str('GENKI_L10') | str('GENKI_K11–s–') | str('GENKI_L20') | str('GENKI_L6-III') | str('GENKI_L4-III') | str('GENKI_K2 _s_') | str('Prior_falsch') | str('rev') | str('GENKI_L8') | str('GENKI_L7-II')
(str("<") >> match("[^\s:>]").repeat(1) >> str(">")).as(:marker) }

# A complete entry

  rule(:preamble) { (preamble_content.repeat(1)).as(:preamble)}
  rule(:preamble?) { preamble.maybe}
  rule(:preamble_content) {pos | dom | tags_with_parens | space}

  rule(:full_entry) { ( preamble? >> (mgr_with_a_b.repeat(1) | any_mgr.repeat(1)) >> space? >> tags_with_parens? >> space? >> str(".").maybe >> space? >> tags_with_parens? >> str(".").maybe).as(:full_entry)}

  rule(:mgr_with_a_b) { str("[") >> thing >> str("]") >> space? >> tags_with_parens? >> space? >> any_mgr.repeat(1) }


# Misc
  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }
  rule(:non_closing) { match("[^>:]").repeat(1) }
  rule(:relation_symbol) { match("[⇔⇒☞→]").as(:relation) }
  rule(:relation_symbol?) { relation_symbol.maybe }
  rule(:text) { match("[^<>()]").repeat(1).as(:text) }
  rule(:seperator) { (match("[.；;]") | str("//")).as(:seperator)}
  rule(:number) { (str("[") >> match('[\d]').repeat(1) >> str("]")).as(:number)}
  rule(:wrong_number) {( str("[") >> match("[^\\]]").repeat(2) >> str("]")).as(:wrong_number)}
  rule(:thing) {match('[A-Z]').repeat(1).as(:thing)}
  
  
  root(:full_entry)
end
