#encoding: utf-8
require "spec_helper"

describe HTMLTransform do
 
  let(:transformer) {HTMLTransform.new}

  it "should transform text elements" do
    tree = {:text => "Ein einfacher Text"}
    res = transformer.apply(tree)
    res.should == "Ein einfacher Text"
  end

  it "should transform HW elements" do
    tree = {:hw=>{:genus=>"f", :text=>"Artischocke"}}
    res = transformer.apply(tree)
    res.should

  end
  

  it "should transform complete entries" do
    text = "(<POS: N.>) <MGr: {<Dom.: Bot.>} <TrE: <HW f: Artischocke>> (<Scientif.: Cynara scolymus>)>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
    res.should == "(<span class='pos'>N.</span>) <span class='mgr'><span class='dom'>Bot.</span>; <span class='tre'><span class='hw'><span class='genus f'>f</span> Artischocke</span></span>; (<span class='scientif'>Cynara scolymus</span>)</span>."

    text = "(<POS: Adv. mit <Transcr.: to> und intrans. V. mit <Transcr.: suru>>) <MGr: <TrE: leuchtend grün>; <TrE: frisch>; <TrE: blass>>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) [1]<MGr: <TrE: grüne <HW f: Erde>>>. [2]<MGr: <TrE: grünes <HW n: Pigment>>>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "<MGr: {<Dom.: Bsp.>} <TrE: Der Schüler übertrifft den Lehrer>> (<Expl.: üblicher ist die Version: <Ref.: <Transcr.: Ao wa ai yori idete ai yori aoshi.> <Jap.: 青は藍よりいでて藍より青し。><DaID: 1127026>>>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) <MGr: {<Dom.: Boxen>} <TrE: <HW f: Ecke> des Champions>; <TrE: <HW f: Ecke> des Titelverteidigers>> (<Ref.: ⇒ <Transcr.: ao·kōnā> <Jap.: 青コーナー><DaID: 0142840>>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) (<LangNiv.: schriftspr.>) <MGr: <TrE: <HW nNAr: Asien> und <HW nNAr: Europa>>; <TrE: <HW nNAr: Eurasien>>> (<Ref.: ⇒ <Transcr.: Ō·A> <Jap.: 欧亜><DaID: 4150094>>)"
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)


    text = "(<POS: N.>) <MGr: {<Dom.: Kleidung>} <TrE: <HW f: Pijacke>>; <TrE: <HW m: Kolani>>> (<Def.: blaue Seemannsüberjacke>；<Etym.: von engl. <For.: pea coat>>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
    
    text = "(<POS: N.>) [A](<Descr.: als Nomen>) [1]<MGr: <TrE: <JLPT2> <HW n: Blau>>> // <MGr: <TrE: <JLPT2><HW n: Grün>>>. [2]<MGr: <TrE: rote <HW f: Ampel>>>. [3]<MGr: <TrE: schwarzes <HW n: Pferd>>; <TrE: blauschwarzes <HW n: Pferd>>>. [4]<MGr: <TrE: <HW n: Aotan> (<Expl.: japan. Kartenspiel>；<Ref.: ⇒ <Transcr.: ao·tan> <Jap.: 青短；青丹><DaID: 3852075>>)>>. [5]<MGr: {<Dom.: Literaturw.>} <TrE: <Ao·HW n: hon> (<Def.: Genre illustrierter Geschichtenbücher mit Kabuki, Jōruri und Kriegsgeschichten>；<Ref.: ⇒ <Transcr.: ao·hon> <Jap.: 青本><DaID: 0116162>>)>>. [6]<MGr: <TrE: <HW f: Bronzemünze> (<Ref.: ⇒ <Transcr.: ao·sen> <Jap.: 青銭><DaID: 1168206>>)>>. [B]<MGr: <TrE: (<Descr.: als Präfix>) unreif>; <TrE: unerfahren>; <TrE: grün>> // <MGr: <TrE: <HW f: Unreife>>; <TrE: <HW f: Unerfahrenheit>>; <TrE: <HW f: Grünheit>. (<Ref.: ⇔ <Transcr.: aka> <Jap.: 赤><DaID: 9345046>>)>>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) <MGr: {<Dom.: Persönlichk.>} <TrE: Peter Michael <FamN.: Blau>>> (<Def.: amerik. Politiksoziologe österr. Abstammung>；<BirthDeath: 1918–>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: Adj.>) [1]<MGr: <TrE: <Prior_1><JLPT2><GENKI_K9, GENKI_K9 _s_>blau.>> // <MGr: <TrE: <Prior_1>grün (<Expl.: z. B. Ampel, Blattwerk>)>>. [2]<MGr: <TrE: <Prior_1>blass>; <TrE: bleich>>. [3]<MGr: <TrE: <Prior_1>unerfahren>>. (<Audio: aoi_Ac2>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
    
    text = "(<POS: N.>) <MGr: {<Dom.: Werktitel>} <TrE: <Title ORIG L_ENG: The Blue <HW NAr: Boy>>>; <TrE: <Title L_DEU: Der <HW NAr: Knabe> in Blau>>> (<Def.: Gemälde von Gainsborough>；<Date: um 1770>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) [1]<MGr: <TrE: <HW m: Doktor>>; <TrE: Dr. (<Expl.: akad. Titel>)>>. [2]<MGr: <TrE: <HW m: Arzt>>; <TrE: <HW m: Doktor>>>. [3]<MGr: <TrE: <HW n: Oberseminar>>; <TrE: <HW m: Graduiertenkurs>>; <TrE: <HW m: Doktorkurs> (<Etym.: Abk. für <Ref.: <Transcr.: <Emph.:dokutā>·kōsu> <Jap.: ドクター･コース><DaID: 0005780>>>). (<Etym.: von engl. <For.: doctor>>)>>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
  
    text = "(<POS: N.>) [A] (<Descr.: als N.>) [1]<MGr: <TrE: <HW n: Rot>>; <TrE: rote <HW f: Farbe> (<Def.: eine der drei Grundfarben>；<Expl.: Farbe des Blutes bzw. Farbton von rosa, orange, rötlich-braun bis braun>；<Expl.: rot kann weiter Goldfarbe symbolisieren>)>>. [2]<MGr: <TrE: rote <HW f: Ampel> (<Ref.: ⇔ <Transcr.: ao> <Jap.: 青><DaID: 2391562>>)>>. [3]<MGr: <TrE: (<LangNiv.: ugs.>) <HW m: Kommunist>>; <TrE: <HW m: Sozialist>>; <TrE: <HW m: Sozi>>; <TrE: <HW m: Roter>>>. [B] <MGr: (<Descr.: als Na.-Adj. mit <Transcr.: no>>) <TrE: vollkommen (<Expl.: nackt, fremd etc.>)>>. [5]<MGr: <TrE: rote <HW f: Zahl>>; <TrE: <HW n: Minus> (<Etym.: Abk. für <Ref.: <Transcr.: akaji> <Jap.: 赤字><DaID: 8114248>>>)>>. [6]<MGr: <TrE: <HW f: Auzki-Bohne> (<Expl.: ursprüngl. in der Geheimsprache der Hofdamen>)>>. [7]<MGr: <TrE: <Def.: eine rote <HW f: Karte> bei den japanischen Spielkarten> (<Etym.: Abk. für <Ref.: <Transcr.: aka·tan> <Jap.: 赤短；赤丹><DaID: 2030089>>>)>>. [8]<MGr: <TrE: rotes <HW n: Team>>; <TrE: die <HW mpl: Roten> (<Expl.: wenn es zwei Teams gibt, von denen das eine weiß und das andere rot ist>)>>. [9]<MGr: <TrE: <Def.: minderwertiger <HW m: Reis> der sich rot verfärbt, wenn er alt wird> (<Etym.: Abk. für <Ref.: <Transcr.: aka·gome> <Jap.: 赤米><DaID: 2339861>>>)>>. [C] <MGr: (<Descr.: als Präfix vor Nomen>) <TrE: vollkommen>; <TrE: vollständig>; <TrE: ganz>; <TrE: offensichtlich>; <TrE: klar>; <TrE: deutlich>>."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) <MGr: {<Dom.: Anat., Med.>} <TrE: <HW f: Diastase>>> (<Def.: Lücke zwischen Knochen od. Muskeln>；<Etym.: <impli.: aus d. Dtsch.><expli.: von engl. <For.: Diastase>>>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
    
    text = "(<POS: N.>) <MGr: <TrE: <HW f: Identifikationsnummer>>> (<Etym.: von engl. <For.: <Emph.:id>entification> und japan. „<Transl.: Nummer>“；Abk.>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) {<Dom.: Persönlichk.>} [1]<MGr: <TrE: William George <FamN.: Armstrong>>> (<Def.: engl. Industrieller>；<BirthDeath: 1810–1900>). [2]<MGr: <TrE: Louis <FamN.: Armstrong>>> (<Def.: amerik. Trompeter und Sänger>；<BirthDeath: 1900–1971>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) [1]{<Dom.: Anat.>} <MGr: <TrE: <HW n: Knochengerüst>>; <TrE: <HW n: Gerippe>>; <TrE: <HW n: Skelett>>> // <MGr: <TrE: <HW m: Körperbau>>; <TrE: <HW m: Bau>>>. [2]<MGr: <TrE: <HW n: Gerüst>>; <TrE: <HW m: Aufbau>>; <TrE: <HW f: Struktur>>; <TrE: <HW m: Rahmen>>; <TrE: <HW mpl: Grundzüge>>>. (<Steinhaus: 27>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "(<POS: N.>) <MGr: {<Dom.: Firmenn.>} <TrE: AT <SpecChar.: &> <HW NAr: T>>; <TrE: American Telephone and Telegraph <HW NAr: Company>>> (<Def.: amerik. Telefongesellschaft>；<Expl.: hervorgegangen aus der Bell Telephone Company>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)

    text = "<MGr: {<Dom.: Med.>} <TrE: <HW n: Dumping-Syndrom>>> (<Def.: Sturzentleerung von Nahrung vom Magen in den Dünndarm>；<WikiDE: Dumping-Syndrom>)."
    tree = WadokuNewGrammar.parse(text)
    res = transformer.apply(tree)
    binding.pry
    
  end


end
