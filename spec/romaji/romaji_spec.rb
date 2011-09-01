#encoding: utf-8
require "spec-helper"

describe Entry do
  it "should transcribe kana in romaji" do
    Entry.kanrom("見通しは明るくなった。").should == "Mitōshi wa akaruku natta."
    Entry.kanrom("人権は普遍的な人類の共通の関心事であることは疑えない。").should == "Jinken wa fuhen·teki na jinrui no kyōtsū no kanshin·ji de aru koto wa utagaenai."
    Entry.kanrom("ベースアップは空頼みに終った。").should == "Bēsu appu wa sora·danomi ni shimatta."
    Entry.kanrom("嚢中無一物である。").should == "Nōchū mu·ichimotsu de aru."
    Entry.kanrom("生暖かい風が吹いてきた。").should == "Nama·atatakai kaze ga fuite kita."
    Entry.kanrom("どうぞこちらへいらっしゃい。").should == "Dōzo kochira e irasshai."
    Entry.kanrom("台風はすべての稲を一夜にしてなぎ倒してしまった。").should == "Taifū wa subete no ine o ichiya ni shite nagi·taoshite shimatta."
    Entry.kanrom("その芳香はしばらく後まで残っていた。").should == "Sono hōkō wa shibaraku ato made nokotte ita."
    Entry.kanrom("少しでも早い方がいい。").should == "Sukoshi demo hayai hō ga ii."
    Entry.kanrom("子どもたちは新しい環境にすぐなじんだ。").should == "Kodomo·tachi wa atarashii kankyō ni sugu najinda."
    Entry.kanrom("ご愁傷のほどお察し申し上げます。").should == "Go·shūshō no hodo o-sasshi·mōshi agemasu."
    Entry.kanrom("彼はドイツに出稼ぎに行ったが、妻と子供たちは家に残った。").should == "Kare wa Doitsu ni dekasegi ni okonatta ga, tsuma to kodomo·tachi wa ie ni nokotta."
    Entry.kanrom("彼女はその三角関係から身を引いた。").should == "Kano·jo wa sono sankaku kankei kara mi o hiita."
    Entry.kanrom("課長は私の改善案を握りつぶした。").should == "Kachō wa watashi no kaizen·an o nigiri·tsubushita."
    Entry.kanrom("核保有国の増加は軍備撤廃への新たな障害となるであろう。").should == "Kakuho yūkoku no zōka wa gunbi teppai e no arata na shōgai to naru de arō."
    Entry.kanrom("後で泣きを入れてきた。").should == "Ato de naki o irete kita."
    Entry.kanrom("赤い花なら何でもよろしい。").should == "Akai hana nara nan·demo yoroshii."
    Entry.kanrom("その相撲は2回水が入った。").should == "Sono sumō wa nikai mizu ga haitta."
    Entry.kanrom("お子さんがお生まれの由でまことに御同慶の至りです。").should == "Okosan ga oumare no yoshi de makoto ni go-dōkei no itari desu."
    Entry.kanrom("ヴェニス").should == "Venisu"
    Entry.kanrom("ヴント").should == "Vunto"
    Entry.kanrom("アクチュアリー").should == "akuchuarī"
    Entry.kanrom("アクティビティ").should == "akutibiti"
    Entry.kanrom("アクチブ").should == "akuchibu"
    Entry.kanrom("アクティブ").should == "akutibu"
  end  
end
