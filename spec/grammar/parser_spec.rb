#encoding: utf-8
#require "citrus"
#Citrus.load("#{Rails.root}/grammar/wadoku_new_2")
require "spec_helper"

describe WadokuNewGrammar do

  it "should parse <POS> tags " do
    parse = WadokuNewGrammar.pos.parse("(<POS: N.>)")
      
    parse[:pos].should_not be_nil
  
    parse = WadokuNewGrammar.pos.parse("(<POS: N., mit <Transcr.: suru> trans. V.>)")
    parse[:pos].should_not be_nil
  end

  it "should parse <Transcr> tags" do
    WadokuNewGrammar.transcr.parse("<Transcr.: kudari>")[:transcr].should_not be_nil
  end

  it "should parse <Descr> tags" do
    text = "<Descr.: als Nomen>" 
    parse = WadokuNewGrammar.descr.parse(text)
    parse.should_not be_nil

  end

  it "should parse <Jap> tags" do 
    WadokuNewGrammar.jap.parse("<Jap.: くだり>")[:jap].should == "くだり"
  end

  it "shoud parse <DaID> tags" do 
    WadokuNewGrammar.daid.parse("<DaID: 9431695>")[:daid].should == "9431695"
  end

  it "should parse <Ref> tags " do
    parse = WadokuNewGrammar.ref.parse("<Ref.: ⇔ <Transcr.: kudari> <Jap.: 下だり><DaID: 9431695>>")
    parse[:transcr].should_not be_nil
    parse[:jap].should == "下だり"
    parse[:daid].should == "9431695"
  end

  it "should parse <Capt> tags" do
    WadokuNewGrammar.capt.parse("<Capt.: Argyle-Muster>")[:capt].should == "Argyle-Muster"
  end

  it "should parse <FileN> tags" do
    WadokuNewGrammar.filen.parse("<FileN: argyl>")[:filen].should == "argyl"
  end

  it "should parse <Pict> tags" do
    parse = WadokuNewGrammar.pict.parse("<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>")[:pict]
    parse[:capt].should == "Argyle-Muster"
    parse[:filen].should == "argyl"
  end

  it "should parse <HW> tags" do
    parse = WadokuNewGrammar.hw.parse("<HW nNAr: Argyle>")[:hw]
    parse[:genus].should == "nNAr"
    parse[:text].should == "Argyle"
  end 

  it "should parse <SeasonW.:> tags " do 
    text = "<SeasonW.: Herbst>"
    parse = WadokuNewGrammar.seasonw.parse(text)
    parse.should_not be_nil
  end

  it "should parse <Expl> tags" do
    parse = WadokuNewGrammar.expl.parse("<Expl.: nach dem schottischen Clan Campbell of Argyle>")
    parse[:expl].first[:text].should == "nach dem schottischen Clan Campbell of Argyle"
  end

  it "should parse <Def> tags" do
    parse = WadokuNewGrammar.defi.parse("<Def.: Verwaltungsgebiet im Westen von Schottland>")
    parse.should_not be_nil

    parse = WadokuNewGrammar.defi.parse("<Def.: röm. Ziffer für „<literal: 100>“>")
    parse.should_not be_nil
    
  end
  
  it "should parse {<Dom>} tags" do
    parse = WadokuNewGrammar.dom.parse("{<Dom.: Gebietsn.>}")
    parse[:dom].should == "Gebietsn."
  end

  it "should parse <Etym.:> tags" do 
    parse = WadokuNewGrammar.etym.parse_with_debug("<Etym.: Abk. für engl. <For.: <Emph.:A>merican <Emph.:S>tandards <Emph.:A>ssociation> = „<Transl.: Normenstelle der USA>“>")
    parse.should_not be_nil
  end
    
  it "should parse tags in parentheses" do
    parse = WadokuNewGrammar.tags_with_parens.parse("(<Def.: Strickmuster mit auf die Ecke gestellter Raute auf einfarbigem Hintergrund>；<Expl.: nach dem schottischen Clan Campbell of Argyle>；<Expl.: Abk.>)")[:tags_with_parens]
    parse.first[:defi].first[:text].should == "Strickmuster mit auf die Ecke gestellter Raute auf einfarbigem Hintergrund"

    text = "(<Expl.: japan. Kartenspiel>；<Ref.: ⇒ <Transcr.: ao·tan> <Jap.: 青短；青丹><DaID: 3852075>>)"
    parse = WadokuNewGrammar.tags_with_parens.parse(text)
    parse.should_not be_nil

    text = "(<Expl.: Abk. für <Ref.: <Transcr.: Ajia> <Jap.: アジア；亜細亜><DaID: 5269320>>>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<Def.: irischer Dramatiker und Schriftsteller>；<BirthDeath: 1883–1971>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<Def.: auf einer Säulenreihe ruhender tragender Querbalken>；<Etym.: <impli.: aus d. Engl.><expli.: von engl. <For.: architrave>>>；<Ref.: ☞ <Transcr.: ākitorēbu> <Jap.: アーキトレーブ><DaID: 9025857>>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<Def.: Empfindlichkeitsbestimmung fotografischen Materials>；<Etym.: Abk. für engl. <For.: <Emph.:A>merican <Emph.:S>tandards <Emph.:A>ssociation> = „<Transl.: Normenstelle der USA>“>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<Expl.: engl. <For.: English Language Proficiency Test>>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil
   
    text = "(<Def.: amerik. Trompeter und Sänger>；<BirthDeath: 1900–1971>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil
    
    text = "(<Def.: engl. Industrieller>；<BirthDeath: 1810–1900>)"
    parse = WadokuNewGrammar.tags_with_parens.parse_with_debug(text)
    parse.should_not be_nil
  end

  it "should parse <TrE> tags" do
    parse = WadokuNewGrammar.tre.parse("<TrE: <HW n: Wappen> mit nach oben gerichteten Glyzinienzweigen>")[:tre]
  
    parse.first[:hw][:genus].should == "n"
    parse.first[:hw][:text].should == "Wappen"
    parse.second[:text].should == " mit nach oben gerichteten Glyzinienzweigen"
    parse = WadokuNewGrammar.tre.parse("<TrE: chinesischer <HW m: Wundervogel>>")
    parse.should_not be_nil

    text = "<TrE: <HW n: Aotan> (<Expl.: japan. Kartenspiel>；<Ref.: ⇒ <Transcr.: ao·tan> <Jap.: 青短；青丹><DaID: 3852075>>)>"
    parse = WadokuNewGrammar.tre.parse(text)
    parse.should_not be_nil

    text = "<TrE: <HW n: Ao·hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>"
    parse = WadokuNewGrammar.tre.parse_with_debug(text)
    parse.should_not be_nil

    text = "<TrE: St. John Greer <FamN.: Ervine>>"
    parse = WadokuNewGrammar.tre.parse_with_debug(text)
    parse.should_not be_nil

    text = "<TrE: <Scientif.: <HW n: Subregnum>>>"
    parse = WadokuNewGrammar.tre.parse_with_debug(text)
    parse.should_not be_nil 
    
  end

  it "should parse <MGr> tags" do
    parse = WadokuNewGrammar.mgr.parse("<MGr: {<Dom.: Gebietsn.>} <TrE: <HW nNAr: Argyle>> (<Def.: Verwaltungsgebiet im Westen von Schottland>)>")[:mgr]
    parse.first[:dom].should == "Gebietsn."
    parse.second[:tre].should_not be_nil
    parse.third[:tags_with_parens].should_not be_nil

    parse = WadokuNewGrammar.mgr.parse_with_debug("<MGr: {<Dom.: Mythol.>} <TrE: chinesischer <HW m: Wundervogel>>; <TrE: <HW m: Phönix>>>")[:mgr]
    parse.first[:dom].should == "Mythol."
    parse.second[:tre].should_not be_nil
    parse.fourth[:tre].should_not be_nil

    text = "<MGr: <TrE: <Prior_1><JLPT2><GENKI_K9, GENKI_K9 _s_>blau.>>"
    parse = WadokuNewGrammar.mgr.parse_with_debug(text)
    parse.should_not be_nil 

  end

  it "should parse wrong <HW> tags " do
  
    text = "<Ao·HW n: hon>"
    parse = WadokuNewGrammar.wrong_hw.parse_with_debug(text)
    parse.should_not be_nil

  end

  it "should parse numbered <MGr>" do
    text = "[5]<MGr: {<Dom.: Literaturw.>} <TrE: <HW n: Ao·hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>>"
    parse = WadokuNewGrammar.numbered_mgr.parse(text)
    parse.should_not be_nil

    text = "[2]<MGr: <TrE: <HW nNAr: Asien> (<Expl.: Abk. für <Ref.: <Transcr.: Ajia> <Jap.: アジア；亜細亜><DaID: 5269320>>>)>>"
    parse = WadokuNewGrammar.numbered_mgr.parse_with_debug(text)
    parse.should_not be_nil

    text = "[2]<MGr: <TrE: Matthew <FamN.: Arnold>> (<Def.: engl. Kritiker und Dichter>；<BirthDeath: 1822–1888>)>"
    parse = WadokuNewGrammar.numbered_mgr.parse_with_debug(text)
    parse.should_not be_nil

    text = "[5]<MGr: {<Dom.: Literaturw.>} <TrE: <Ao·HW n: hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>>"
    parse = WadokuNewGrammar.numbered_mgr.parse_with_debug(text)
    parse.should_not be_nil
  end

  it "should parse mgrs with a and b" do
    text = "[B]<MGr: <TrE: (<Descr.: als Präfix>) unreif>; <TrE: unerfahren>; <TrE: grün>> // <MGr: <TrE: <HW f: Unreife>>; <TrE: <HW f: Unerfahrenheit>>; <TrE: <HW f: Grünheit>. (<Ref.: ⇔ <Transcr.: aka> <Jap.: 赤><DaID: 9345046>>)>>."
    parse = WadokuNewGrammar.mgr_with_a_b.parse(text)
    parse.should_not be_nil

    text = "[A](<Descr.: als Nomen>) [1]<MGr: <TrE: <JLPT2> <HW n: Blau>>> // <MGr: <TrE: <JLPT2><HW n: Grün>>>. [2]<MGr: <TrE: rote <HW f: Ampel>>>. [3]<MGr: <TrE: schwarzes <HW n: Pferd>>; <TrE: blauschwarzes <HW n: Pferd>>>. [4]<MGr: <TrE: <HW n: Aotan> (<Expl.: japan. Kartenspiel>；<Ref.: ⇒ <Transcr.: ao·tan> <Jap.: 青短；青丹><DaID: 3852075>>)>>. [5]<MGr: {<Dom.: Literaturw.>} <TrE: <HW n: Ao·hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>>. [6]<MGr: <TrE: <HW f: Bronzemünze> (<Ref.: ⇒ <Transcr.: ao·sen> <Jap.: 青銭><DaID: 1168206>>)>>."
    parse = WadokuNewGrammar.mgr_with_a_b.parse_with_debug(text)
    parse.should_not be_nil

    text = "[C] <MGr: (<Descr.: als Präfix vor Nomen>) <TrE: vollkommen>; <TrE: vollständig>; <TrE: ganz>; <TrE: offensichtlich>; <TrE: klar>; <TrE: deutlich>>."
    parse = WadokuNewGrammar.mgr_with_a_b.parse_with_debug(text)
    parse.should_not be_nil

    text = "[B] <MGr: (<Descr.: als Na.-Adj. mit <Transcr.: no>>) <TrE: vollkommen (<Expl.: nackt, fremd etc.>)>>. [5]<MGr: <TrE: rote <HW f: Zahl>>; <TrE: <HW n: Minus> (<Etym.: Abk. für <Ref.: <Transcr.: akaji> <Jap.: 赤字><DaID: 8114248>>>)>>. [6]<MGr: <TrE: <HW f: Auzki-Bohne> (<Expl.: ursprüngl. in der Geheimsprache der Hofdamen>)>>. [7]<MGr: <TrE: <Def.: eine rote <HW f: Karte> bei den japanischen Spielkarten> (<Etym.: Abk. für <Ref.: <Transcr.: aka·tan> <Jap.: 赤短；赤丹><DaID: 2030089>>>)>>. [8]<MGr: <TrE: rotes <HW n: Team>>; <TrE: die <HW mpl: Roten> (<Expl.: wenn es zwei Teams gibt, von denen das eine weiß und das andere rot ist>)>>. [9]<MGr: <TrE: <Def.: minderwertiger <HW m: Reis> der sich rot verfärbt, wenn er alt wird> (<Etym.: Abk. für <Ref.: <Transcr.: aka·gome> <Jap.: 赤米><DaID: 2339861>>>)>>."
    parse = WadokuNewGrammar.mgr_with_a_b.parse_with_debug(text)
    parse.should_not be_nil
  end

  it "should parse a full entry" do
    text = "(<POS: N.>) <MGr: {<Dom.: Mythol.>} <TrE: chinesischer <HW m: Wundervogel>>; <TrE: <HW m: Phönix>>> (<Pict.: <Capt.: Tanzender Phönix><FileN: maihouou>>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [1]<MGr: {<Dom.: Gebietsn.>} <TrE: <HW nNAr: Argyle>> (<Def.: Verwaltungsgebiet im Westen von Schottland>)>. [2]<MGr: <TrE: <HW n: Argyle-Muster>> (<Def.: Strickmuster mit auf die Ecke gestellter Raute auf einfarbigem Hintergrund>；<Expl.: nach dem schottischen Clan Campbell of Argyle>；<Expl.: Abk.>)>. (<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>)."

    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: N., mit <Transcr.: suru> trans. V.>) <MGr: <TrE: <JLPT2><GENKI_K5><HW m: Test>>; <TrE: <JLPT2><GENKI_K5><HW f: Probe>>; <TrE: <JLPT2><GENKI_K5><HW f: Prüfung>>; <TrE: <HW n: Quiz>>>. (<Audio: tesuto_Ac1>)."
    parse = WadokuNewGrammar.parse(text)
    
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Mythol.>} <TrE: chinesischer <HW m: Wundervogel>>; <TrE: <HW m: Phönix>>> (<Pict.: <Capt.: Tanzender Phönix><FileN: maihouou>>)."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [A](<Descr.: als Nomen>) [1]<MGr: <TrE: <JLPT2> <HW n: Blau>>> // <MGr: <TrE: <JLPT2><HW n: Grün>>>. [2]<MGr: <TrE: rote <HW f: Ampel>>>. [3]<MGr: <TrE: schwarzes <HW n: Pferd>>; <TrE: blauschwarzes <HW n: Pferd>>>. [4]<MGr: <TrE: <HW n: Aotan> (<Expl.: japan. Kartenspiel>；<Ref.: ⇒ <Transcr.: ao·tan> <Jap.: 青短；青丹><DaID: 3852075>>)>>. [5]<MGr: {<Dom.: Literaturw.>} <TrE: <HW n: Ao·hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>>. [6]<MGr: <TrE: <HW f: Bronzemünze> (<Ref.: ⇒ <Transcr.: ao·sen> <Jap.: 青銭><DaID: 1168206>>)>>. [B]<MGr: <TrE: (<Descr.: als Präfix>) unreif>; <TrE: unerfahren>; <TrE: grün>> // <MGr: <TrE: <HW f: Unreife>>; <TrE: <HW f: Unerfahrenheit>>; <TrE: <HW f: Grünheit>. (<Ref.: ⇔ <Transcr.: aka> <Jap.: 赤><DaID: 9345046>>)>>."
  
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: <TrE: <HW NAr: C>>; <TrE: hundert>> (<Def.: röm. Ziffer für „<literal: 100>“>)."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil
    
    text = "(<POS: N.>) <MGr: <TrE: <HW f: Eins>>; <TrE: <HW f: I>>; <TrE: <HW f: 1>>> (<Def.: röm. Ziffer für „<Topic: 1>“>)."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil
    
    text = "(<POS: N.>) <MGr: <TrE: <HW f: L>>> (<Def.: röm. Ziffer für „<literal: 50>“>)."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [1]<MGr: <TrE: <HW n: a>>; <TrE: <HW n: A>>; <TrE: <HW m: Vokal> „<Topic: a>“>; <TrE: <HW m: Lautwert> „<Topic: a>“>> // <MGr: <TrE: <HW m: Lautwert> „<Topic: a>“ in der 50-Laute-Tafel>; <TrE: erstes <HW n: Zeichen> der ersten Reihe der 50-Laute-Tafel>; <TrE: 36. <HW n: Zeichen> des Iroha-Gedichtes>>. [2]<MGr: <TrE: <HW n: Hiragana> „<Topic: a>“>; <TrE: <Jap.: あ>>; <TrE: <HW n: Katakana> „<Topic: a>“>; <TrE: <Jap.: ア>>>."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [1]<MGr: <TrE: Sub…>; <TrE: Unter…>; <TrE: Neben…>>. [2]<MGr: <TrE: <HW nNAr: Asien> (<Expl.: Abk. für <Ref.: <Transcr.: Ajia> <Jap.: アジア；亜細亜><DaID: 5269320>>>)>>. [3]<MGr: <TrE: <HW nNAr: Argentinien> (<Expl.: Abk. für <Ref.: <Transcr.: Aruzenchin> <Jap.: 亜爾然丁><DaID: 8205696>>>)>>. [4]<MGr: <TrE: <HW nNAr: Amerika> (<Expl.: Abk. für <Ref.: <Transcr.: Amerika> <Jap.: アメリカ；亜米利加><DaID: 3452271>>>)>>. [5]<MGr: <TrE: <HW nNAr: Arabien> (<Etym.: Abk. für <Ref.: <Transcr.: Arabia> <Jap.: アラビア；亜剌比亜><DaID: 7387131>>>)>>."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: Kanji>) {<Dom.: Einzel-Kanji>} [1]<MGr: <TrE: <HW m: Winkel>>>. [2]<MGr: <TrE: <HW n: Schmeicheln>>>. [3]<MGr: <TrE: <HW n: Vordach>>>. [4]<MGr: <TrE: <HW m: Hügel>>>. [5]<MGr: <TrE: <HW nNAr: Afrika> (<Expl.: Abk.>)>>. [6]<MGr: <TrE: <HW n: A> (<Def.: erster Buchstabe des Sanskrit-Alphabets>)>>."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: Adv.>) <MGr: <TrE: <Prior_1>so>; <TrE: auf jene Art>>. (<Audio: ā_Ac1>)."
    parse = WadokuNewGrammar.parse(text)
    parse.should_not be_nil

    text = "(<POS: Adv.>) (<Usage: onomat.>) <MGr: <TrE: krah!> (<Expl.: Krächzen ein Krähe>)>. (<Audio: ā_Ac1>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Persönlichk.>} <TrE: St. John Greer <FamN.: Ervine>>(<Def.: irischer Dramatiker und Schriftsteller>；<BirthDeath: 1883–1971>)> ."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Org., Gesch.>} <TrE: <HW NAr: ASN>>; <TrE: Sowjetische <HW f: Nachrichtenagentur>>> (<Etym.: Abk. für russ. <For.: <Emph.:A>gentstwo <Emph.:S>owjet <Emph.:N>jus>>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) {<Dom.: Persönlichk.>} [1]<MGr: <TrE: Washington <FamN.: Irving>>(<Def.: amerik. Schriftsteller>；<BirthDeath: 1783–1859>)> . [2]<MGr: <TrE: John <FamN.: Irving>>(<Def.: amerik. Schriftsteller>；<BirthDeath: 1942–>)> ."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Archit.>} <TrE: <HW m: Architrav>>; <TrE: <HW n: Epistylion>> (<Def.: auf einer Säulenreihe ruhender tragender Querbalken>；<Etym.: <impli.: aus d. Engl.><expli.: von engl. <For.: architrave>>>；<Ref.: ☞ <Transcr.: ākitorēbu> <Jap.: アーキトレーブ><DaID: 9025857>>)>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Fotog.>} <TrE: <HW nNAr: ASA>>; <TrE: <HW f: Lichtempfindlichkeit> nach ASA>> (<Def.: Empfindlichkeitsbestimmung fotografischen Materials>；<Etym.: Abk. für engl. <For.: <Emph.:A>merican <Emph.:S>tandards <Emph.:A>ssociation> = „<Transl.: Normenstelle der USA>“>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: Na.-Adj. mit <Transcr.: na> bzw. präd. mit <Transcr.: da> etc.>) <MGr: <TrE: erdig>; <TrE: derb>> (<Etym.: von engl. <For.: earthy>>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Bot.>} <TrE: <HW f: Artischocke>> (<Scientif.: Cynara scolymus>)>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [1]<MGr: <TrE: <HW f: Kunst>>; <TrE: schöne <HW fpl: Künste>>>. [2]<MGr: <TrE: <HW f: Kunst>>; <TrE: <HW f: Kunstfertigkeit>>>. [3]<MGr: <TrE: etw. <HW nNAr: Künstliches>>; <TrE: <HW n: Menschenwerk>>>. [4]<MGr: <TrE: <HW n: Kunstdruckpapier> (<Expl.: Abk. für <Ref.: <Transcr.: <Emph.:āto>·pēpā> <Jap.: アート･ペーパー><DaID: 1175936>>>)>>. [5]<MGr: <TrE: <HW f: Werbekunst>>; <TrE: <HW f: Werbung>. (<Etym.: von engl. <For.: art>>). (<Ref.: ⇒ <Transcr.: bijutsu> <Jap.: 美術><DaID: 7612923>>)>>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) {<Dom.: Persönlichk.>} [1]<MGr: <TrE: Thomas <FamN.: Arnold>> (<Def.: Pädagoge und Historiker>；<BirthDeath: 1795–1842>)>. [2]<MGr: <TrE: Matthew <FamN.: Arnold>> (<Def.: engl. Kritiker und Dichter>；<BirthDeath: 1822–1888>)>. [3]<MGr: <TrE: Edwin <FamN.: Arnold>> (<Def.: engl. Dichter und Journalist>；<BirthDeath: 1832–1904>)>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: Adj.>) [1]<MGr: <TrE: <Prior_1><JLPT2><GENKI_K9, GENKI_K9 _s_>blau.>> // <MGr: <TrE: <Prior_1>grün (<Expl.: z. B. Ampel, Blattwerk>)>>. [2]<MGr: <TrE: <Prior_1>blass>; <TrE: bleich>>. [3]<MGr: <TrE: <Prior_1>unerfahren>>. (<Audio: aoi_Ac2>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) <MGr: {<Dom.: Biol.>} <TrE: <HW n: Unterreich>>; <TrE: <Scientif.: <HW n: Subregnum>>>>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    
    text = "(<POS: Adj.>) [1_Gb]<MGr: <TrE: <Prior_1><JLPT2><GENKI_K9, GENKI_K9–s–>rot>>. [2]<MGr: <TrE: kommunistisch>>. (<Audio: akai_Ac3>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "<MGr: <TrE: <HW m: Englisch-Leistungstest>> (<Expl.: engl. <For.: English Language Proficiency Test>>)>."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) {<Dom.: Persönlichk.>} [1]<MGr: <TrE: William George <FamN.: Armstrong>>> (<Def.: engl. Industrieller>；<BirthDeath: 1810–1900>). [2]<MGr: <TrE: Louis <FamN.: Armstrong>>> (<Def.: amerik. Trompeter und Sänger>；<BirthDeath: 1900–1971>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil

    text = "(<POS: N.>) [1]{<Dom.: Anat.>} <MGr: <TrE: <HW n: Knochengerüst>>; <TrE: <HW n: Gerippe>>; <TrE: <HW n: Skelett>>> // <MGr: <TrE: <HW m: Körperbau>>; <TrE: <HW m: Bau>>>. [2]<MGr: <TrE: <HW n: Gerüst>>; <TrE: <HW m: Aufbau>>; <TrE: <HW f: Struktur>>; <TrE: <HW m: Rahmen>>; <TrE: <HW mpl: Grundzüge>>>. (<Steinhaus: 27>)."
    parse = WadokuNewGrammar.parse_with_debug(text)
    parse.should_not be_nil
  end

end
