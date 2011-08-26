#encoding: utf-8
#require "citrus"
#Citrus.load("#{Rails.root}/grammar/wadoku_new_2")
require "spec_helper"

describe WadokuNewGrammar do
  it "should parse <MGr> tags" do
    WadokuNewGrammar.parse("[1]<MGr: <TrE: <HW m: Vogel> des Glücks>> //", :root => :meaning_group).to_html.should == "<span class='mg_nr'>[1]</span> <span class='tre'><span class='genus m'>Vogel</span> des Glücks</span> //"
    WadokuNewGrammar.parse("[1]<MGr: {<Dom.: Elektrot.>} <TrE: <HW f: Erdung>>; <TrE: <HW f: Erde>>; <TrE: <HW m: Erdschluss>>; <TrE: <HW f: Erdleitung>>>.", :root => :meaning_group).to_html.should == "<span class='mg_nr'>[1]</span> {<span class='dom'>Elektrot.</span>} <span class='tre'><span class='genus f'>Erdung</span>; </span><span class='tre'><span class='genus f'>Erde</span>; </span><span class='tre'><span class='genus m'>Erdschluss</span>; </span><span class='tre'><span class='genus f'>Erdleitung</span></span>." 
    WadokuNewGrammar.parse("[2]<MGr: <TrE: <HW f: Erde>>; <TrE: <HW m: Boden>>>.", :root => :meaning_group).to_html.should =="<span class='mg_nr'>[2]</span> <span class='tre'><span class='genus f'>Erde</span>; </span><span class='tre'><span class='genus m'>Boden</span></span>."
  end

  it "should parse bracketed_tags" do
    WadokuNewGrammar.parse("(<Etym.: von engl. <For.: earth>>).", :root => :bracketed_tags).to_html.should == "(<span class='etym'>von engl. <span class='for'>earth</span></span>)."
  end
  
  it "should parse tags after <MGr> tags" do
    WadokuNewGrammar.parse("[1]<MGr: {<Dom.: Elektrot.>} <TrE: <HW f: Erdung>>; <TrE: <HW f: Erde>>; <TrE: <HW m: Erdschluss>>; <TrE: <HW f: Erdleitung>>>. [2]<MGr: <TrE: <HW f: Erde>>; <TrE: <HW m: Boden>>>. (<Etym.: von engl. <For.: earth>>).").to_html.should == "<span class='mg_nr'>[1]</span> {<span class='dom'>Elektrot.</span>} <span class='tre'><span class='genus f'>Erdung</span>; </span><span class='tre'><span class='genus f'>Erde</span>; </span><span class='tre'><span class='genus m'>Erdschluss</span>; </span><span class='tre'><span class='genus f'>Erdleitung</span></span>. <span class='mg_nr'>[2]</span> <span class='tre'><span class='genus f'>Erde</span>; </span><span class='tre'><span class='genus m'>Boden</span></span>. (<span class='etym'>von engl. <span class='for'>earth</span></span>)."  
  end

  it "should parse <LangNiv.:...> tags" do
    WadokuNewGrammar.parse("(<LangNiv.: ugs.>) ", :root => :bracketed_tags).to_html.should == "(<span class='langniv'>ugs.</span>) "
    WadokuNewGrammar.parse("(<LangNiv.: schriftspr.>) ", :root => :bracketed_tags).to_html.should == "(<span class='langniv'>schriftspr.</span>) "
  end

  it "should parse <Ref> tags " do
    WadokuNewGrammar.parse("<Ref.: ⇔ <Transcr.: kudari> <Jap.: 下だり><DaID: 9431695>>", :root => :ref).to_html.should == "⇔ <a href='<<<ROOT_URL>>>entries/by-daid/9431695'><span class='jap'>下だり</span> - <span class='transcr'>kudari</span></a>" 

  end

  it "should parse <Pict> tags" do
    WadokuNewGrammar.parse("<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>", :root => :pict).to_html.should == "<span class='svg_image'><span class='image_caption'>Argyle-Muster</span><span class='svg'><a href='<<<ROOT_URL>>>svg/argyl.svg'><img src='<<<ROOT_URL>>>svg/argyl.svg' type='image/svg+xml' /></a></span></span>"
  end

  it "should parse <Pict> tags in context" do
    
    example = "(<POS: N.>) [1]<MGr: {<Dom.: Gebietsn.>} <TrE: <HW nNAr: Argyle>> (<Def.: Verwaltungsgebiet im Westen von Schottland>)>. [2]<MGr: <TrE: <HW n: Argyle-Muster>>> (<Def.: Strickmuster mit auf die Ecke gestellter Raute auf einfarbigem Hintergrund>；<Expl.: nach dem schottischen Clan Campbell of Argyle>；<Expl.: Abk.>). (<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>)."

    WadokuNewGrammar.parse(example).to_html.should include "<span class='svg_image'><span class='image_caption'>Argyle-Muster</span><span class='svg'><a href='<<<ROOT_URL>>>svg/argyl.svg'><img src='<<<ROOT_URL>>>svg/argyl.svg' type='image/svg+xml' /></a></span></span>"

    example2 = "(<POS: N.>) <MGr: {<Dom.: Kleidung>} <TrE: <HW m: Aioi-Knoten> (<Expl.: ein Zierknoten für Gürtel>). (<Pict.: <Capt.: Aioi-Knoten><FileN: aioimusubi>>)>>."

    WadokuNewGrammar.parse(example2).to_html.should include "<span class='svg_image'><span class='image_caption'>Aioi-Knoten</span><span class='svg'><a href='<<<ROOT_URL>>>svg/aioimusubi.svg'><img src='<<<ROOT_URL>>>svg/aioimusubi.svg' type='image/svg+xml' /></a></span></span>"

    example3 = "(<POS: N.>) <MGr: <TrE: <HW n: Wappen> mit nach oben gerichteten Glyzinienzweigen>> (<Ref.: ⇔ <Transcr.: sagari·fuji> <Jap.: 下がり藤><DaID: 4761597>>；<Pict.: <Capt.: Agari·fuji><FileN: agarifuji>>)."

    WadokuNewGrammar.parse(example3).to_html.should include "<span class='svg_image'><span class='image_caption'>Agari·fuji</span><span class='svg'><a href='<<<ROOT_URL>>>svg/agarifuji.svg'><img src='<<<ROOT_URL>>>svg/agarifuji.svg' type='image/svg+xml' /></a></span></span>"

    example4 = "(<POS: N.>) <MGr: {<Dom.: Mythol.>} <TrE: chinesischer <HW m: Wundervogel>>; <TrE: <HW m: Phönix>>> (<Pict.: <Capt.: Tanzender Phönix><FileN: maihouou>>)."

    WadokuNewGrammar.parse(example4).to_html.should include "<span class='svg_image'><span class='image_caption'>Tanzender Phönix</span><span class='svg'><a href='<<<ROOT_URL>>>svg/maihouou.svg'><img src='<<<ROOT_URL>>>svg/maihouou.svg' type='image/svg+xml' /></a></span></span>"

  end

  it "should parse audio tags" do
    WadokuNewGrammar.parse("(<Audio: tesuto_Ac1>)", :root => :audio_tag).should == "(<Audio: tesuto_Ac1>)"

    WadokuNewGrammar.parse("(<Audio: otoko·no·ko_Ac3>)", :root => :audio_tag).should == "(<Audio: otoko·no·ko_Ac3>)"
  end

  it "should give audio file name in context" do

    example = "(<POS: N., mit <Transcr.: suru> trans. V.>) <MGr: <TrE: <JLPT2><GENKI_K5><HW m: Test>>; <TrE: <JLPT2><GENKI_K5><HW f: Probe>>; <TrE: <JLPT2><GENKI_K5><HW f: Prüfung>>; <TrE: <HW n: Quiz>>>. (<Audio: tesuto_Ac1>)."

    WadokuNewGrammar.parse(example).audio_file.should == "tesuto_Ac1"

  end


end
