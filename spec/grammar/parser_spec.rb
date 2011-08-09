#encoding: utf-8
#require "citrus"
#Citrus.load("#{Rails.root}/grammar/wadoku_new_2")
require "spec_helper"

describe WadokuNewGrammar do

  it "should parse <Pict> tags" do
    WadokuNewGrammar.parse("<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>", :root => :pict).to_html.should == "<span class='svg_image'><span class='image_caption'>Argyle-Muster</span><span class='svg'></span><embed src='<<<ROOT_URL>>>svg/argyl.svg' type='image/svg+xml' /></span>"
  end

  it "should parse <Pict> tags in context" do
    
    example = "(<POS: N.>) [1]<MGr: {<Dom.: Gebietsn.>} <TrE: <HW nNAr: Argyle>> (<Def.: Verwaltungsgebiet im Westen von Schottland>)>. [2]<MGr: <TrE: <HW n: Argyle-Muster>>> (<Def.: Strickmuster mit auf die Ecke gestellter Raute auf einfarbigem Hintergrund>；<Expl.: nach dem schottischen Clan Campbell of Argyle>；<Expl.: Abk.>). (<Pict.: <Capt.: Argyle-Muster><FileN: argyl>>)."

    WadokuNewGrammar.parse(example).to_html.should include "<span class='svg_image'><span class='image_caption'>Argyle-Muster</span><span class='svg'></span><embed src='<<<ROOT_URL>>>svg/argyl.svg' type='image/svg+xml' /></span>"

  end

end
