#encoding: utf-8
require "spec_helper"

describe Entry do

  before do 
    @aoidomoe = Entry.new
    @aoidomoe.definition = " <MGr: <TrE: <HW n: Malvenwappen>> (<Expl.: ein japan. Familienwappen mit kreisförmig angeordneten Malvenblättern>；<Expl.: von der Familie Tokugawa verwendet>；<Pict.: <Capt.: Malvenwappen><FileN: aoi>>)>."

  end

  it "should do some small modifications on the html" do
    
    @aoidomoe.to_html.should == "<span class='mg_nr'><span> <span class='tre'><span class='genus n'>Malvenwappen</span> </span> (<span class='expl'>ein japan. Familienwappen mit kreisförmig angeordneten Malvenblättern</span>; <span class='expl'>von der Familie Tokugawa verwendet</span>; ).<span class='svg_image'><span class='image_caption'>Malvenwappen</span><span class='svg'><a href='svg/aoi.svg'><img src='svg/aoi.svg' type='image/svg+xml' /></a></span></span>"
    

  end

  it "should parse" do
    @aoidomoe.parse.should_not include "Fehler"
  end

end
