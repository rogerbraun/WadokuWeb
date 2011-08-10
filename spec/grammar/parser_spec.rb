#encoding: utf-8
#require "citrus"
#Citrus.load("#{Rails.root}/grammar/wadoku_new_2")
require "spec_helper"

describe WadokuNewGrammar do

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

end
