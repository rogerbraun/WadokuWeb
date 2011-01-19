#encoding: utf-8
require "rubygems"
require "citrus"
require "test/unit"
require "cgi"

Citrus.load("wadoku_new")

class WadokuGrammarTest < Test::Unit::TestCase
  
  def test_word
    str = "abcdefgöäüß"
    match = WadokuGrammar.parse(str, :root => :word)
    assert(match)
    assert_equal(str, match)
    assert_equal(str, match.to_html)
  end 

  def test_words
    str = "nicht benötigen"
    match = WadokuGrammar.parse(str, :root => :words)
    assert match
    assert_equal str, match
    assert_equal str, match.to_html

    str = "guten"
    match = WadokuGrammar.parse(str, :root => :words)
    assert match
    assert_equal str, match
    assert_equal str, match.to_html
  end

  def test_marker
    match = WadokuGrammar.parse("<JLPT1>", :root => :marker)
    assert(match)
    assert_equal "<JLPT1>", match
    assert_equal "<span class='jlpt1'></span>", match.to_html

    match = WadokuGrammar.parse("<GENKI_1>", :root => :marker)
    assert(match)
    assert_equal "<GENKI_1>", match
    assert_equal "<span class='genki_1'></span>", match.to_html
  end

#  def test_constituent
#    match = WadokuGrammar.parse("nicht benötigen", :root => :constituent)
#    assert match
#    assert_equal "nicht benötigen", match
#    assert_equal "nicht benötigen", match.to_html
#  end

  def test_subsubentry
    match = WadokuGrammar.parse("nicht benötigen;", :root => :subsubentry)
    assert match
    assert_equal "nicht benötigen;", match
    assert_equal "nicht benötigen;", match.to_html
 
    match = WadokuGrammar.parse("<JLPT1> nicht benötigen;", :root => :subsubentry)
    assert match
    assert_equal "<JLPT1> nicht benötigen;", match
    assert_equal "<span class='jlpt1'>nicht benötigen</span>;", match.to_html

  end

  def test_subentry
    match = WadokuGrammar.parse("nicht benötigen; blablub; ohne zurecht kommen.", :root => :subentry)
    assert match
    assert_equal "nicht benötigen; blablub; ohne zurecht kommen.", match.to_html

    match = WadokuGrammar.parse("<GENKI_1>nicht benötigen.", :root => :subentry)
    assert match
    assert_equal "<GENKI_1>nicht benötigen.", match
    assert_equal "<span class='genki_1'>nicht benötigen</span>.", match.to_html

    match = WadokuGrammar.parse("<GENKI_1> nicht benötigen; <test> was auch immer; und ein <gut> dummer test.", :root => :subentry)
    assert match
    assert_equal "<span class='genki_1'>nicht benötigen</span>; <span class='test'>was auch immer</span>; und ein <span class='gut'>dummer test</span>.", match.to_html

    match = WadokuGrammar.parse("[1] <GENKI_1> nicht benötigen; <test> was auch immer; und ein <gut> dummer test.", :root => :subentry)
    assert match
    assert_equal "[1]: <span class='genki_1'>nicht benötigen</span>; <span class='test'>was auch immer</span>; und ein <span class='gut'>dummer test</span>.", match.to_html

    match = WadokuGrammar.parse("Spaß<Gen.: m> am Rauchen; Vorliebe<Gen.: f> fürs Rauchen.")
    assert match
    assert_equal "<span class='gen_m'>Spaß</span> am Rauchen; <span class='gen_f'>Vorliebe</span> fürs Rauchen.", match.to_html

  end

  def test_pos
    match = WadokuGrammar.parse("(<POS: N.>)", :root => :pos)
    assert match
    assert_equal "POS", match.to_html

    match = WadokuGrammar.parse("(<POS: 5‑st. intrans. V. auf <Transcr.: ‑ma> <Expl.: mit regelm. Nasal‑Onbin = <Transcr.: ‑nde>>>)", :root => :pos)
    assert match
    assert_equal("POS", match.to_html)
  end

  def test_entry
    str = "(<POS: N.>) [1] <JLPT2> enden; zu Ende gehen; <JLPT2> beendet werden; zu Ende sein; beendet sein; fertig sein. [2] nicht benötigen; ohne zurecht kommen. [3] bezahlt werden."
    match = WadokuGrammar.parse(str)
    assert match
    assert_equal "[1]: <span class='jlpt2'>enden</span>; zu Ende gehen; <span class='jlpt2'>beendet werden</span>; zu Ende sein; beendet sein; fertig sein. [2]: nicht benötigen; ohne zurecht kommen. [3]: bezahlt werden.", match.to_html

    str = "Problem<Gen.: n>, das mit Geld nicht zu lösen ist."
    match = WadokuGrammar.parse(str)
    assert match
    assert_equal "<span class='gen_n'>Problem</span>, das mit Geld nicht zu lösen ist.", match.to_html

    str = "(<POS: Adn.>) süß; nett; charmant; liebenswürdig; umgänglich (<Usage: klassisches Japanisch>)."
    match = WadokuGrammar.parse(str)
    assert match
    assert_equal "süß; nett; charmant; liebenswürdig; umgänglich (<span class='usage'>klassisches Japanisch</span>).", match.to_html

    str = "(<POS: N., mit <Transcr.: suru> trans. V.>) liebevolle Erziehung<Gen.: f>."
    match = WadokuGrammar.parse(str)
    assert match
    assert_equal "liebevolle <span class='gen_f'>Erziehung</span>.", match.to_html

    str = "(<POS: N.>) {<Dom.: Verlagsn.>} Aiiku Shuppan (<Expl.: Tōkyō>)."
    match = WadokuGrammar.parse(str)
    assert match
    #assert_equal "<span class='dom'>Verlagsn.</span> Aiiku Shuppan (<span class='expl'>Tōkyō</span>).", match.to_html


    str = "(<POS: N.>) {<Dom.: männl. Name>} Aiichi."
    match = WadokuGrammar.parse(str)
    assert match
    #assert_equal "<span class='dom'>männl. Name</span> Aiichi.",match.to_html

    str = "(<POS: N.>) {<Dom.: Stadtn.>} Aihui<Gen.: nNAr> (<Def.: Stadt im Nordosten Chinas an der Grenze zu Russland>)."
    match = WadokuGrammar.parse(str)
    assert match
    #assert_equal "<span class='dom'>Stadtn.</span> <span class='gen_nnar'>Aihui</span> (<span class='def'>Stadt im Nordosten Chinas an der Grenze zu Russland</span>).", match.to_html


    str = "(<POS: N.>) {<Dom.: Stadtn.>} Aikawa (<Def.: Stadt im Norden der Präf. Kanagawa>)."
    match = WadokuGrammar.parse(str)
    assert match
    #assert_equal "<span class='dom'>Stadtn.</span> Aikawa (<span class='def'>Stadt im Norden der Präf. Kanagawa</span>).", match.to_html

    str = "(<POS: N., mit <Transcr.: suru> trans. V.>) Spaß<Gen.: m> am Rezitieren; Spaß<Gen.: m> am Lesen (<Ref.: ⇒ <Transcr.: aigin> <Jap.: 愛吟><DaID: 4912007>>)."
    match = WadokuGrammar.parse(str)
    assert match
    #assert_equal "<span class='gen_m'>Spaß</span> am Rezitieren; <span class='gen_m'>Spaß</span> am Lesen (⇒ <a href='<<<ROOT_URL>>>entries/by-daid/4912007'>愛吟 - <span class='transcr'>aigin</span></a>).", match.to_html

    #str = "(<POS: N.>) {<Dom.: Gebietsn.>} Aichi<Gen.: nNAr> (<Def.: Name einer Präf. in der Chūbu-Region>; <Expl.: Präfekturhauptstadt ist Nagoya>)."
    #match = WadokuGrammar.parse(str)
    #assert match
    #assert_equal "<span class='dom'>Gebietsn.</span> <span class='def'>Name einer Präf. in der Chūbu-Region</span>", match.to_html
  end
    
  def test_body
    str = "[1] <JLPT2> enden; zu Ende gehen; <JLPT2> beendet werden; zu Ende sein; beendet sein; fertig sein. [2] nicht benötigen; ohne zurecht kommen. [3] bezahlt werden."
    match = WadokuGrammar.parse(str,:root => :body)
    assert match
    assert_equal "[1]: <span class='jlpt2'>enden</span>; zu Ende gehen; <span class='jlpt2'>beendet werden</span>; zu Ende sein; beendet sein; fertig sein. [2]: nicht benötigen; ohne zurecht kommen. [3]: bezahlt werden.", match.to_html
  end

  def test_ref
    match = WadokuGrammar.parse("(<Ref.: → <Transcr.: aichaku> <Jap.: 愛着><DaID: 1226801>>)", :root => :ref)
    assert match
    assert_equal "(→ <a href='<<<ROOT_URL>>>entries/by-daid/1226801'>愛着 - <span class='transcr'>aichaku</span></a>)", match.to_html
  end


  def test_transcr
    str = "<Transcr.: ‑ma>"
    match = WadokuGrammar.parse(str, :root => :transcr)
    assert match
    assert_equal "<span class='transcr'>‑ma</span>", match.to_html
  end
end 
