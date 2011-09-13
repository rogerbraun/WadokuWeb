#encoding: utf-8

PIPELINETAB1 = "\
あ	あ|	い	い|	う	う|	え	え|	お	お|
か	か|	き	き|	く	く|	け	け|	こ	こ|
さ	さ|	し	し|	す	す|	せ	せ|	そ	そ|
た	た|	ち	ち|	つ	つ|	て	て|	と	と|
な	な|	に	に|	ぬ	ぬ|	ね	ね|	の	の|
は	は|	ひ	ひ|	ふ	ふ|	へ	へ|	ほ	ほ|
ま	ま|	み	み|	む	む	め	め|	も	も|
や	や|	ゆ	ゆ|	よ	よ|
ら	ら|	り	り|	る	る|	れ	れ|	ろ	ろ|
わ	わ|	ゐ	ゐ|	ゑ	ゑ|	を	を|	ん	ん|
が	が|	ぎ	ぎ|	ぐ	ぐ|	げ	げ|	ご	ご|
ざ	ざ|	じ	じ|	ず	ず|	ぜ	ぜ|	ぞ	ぞ|
だ	だ|	ぢ	ぢ|	づ	づ|	で	で|	ど	ど|
ば	ば|	び	び|	ぶ	ぶ|	べ	べ|	ぼ	ぼ|
ぱ	ぱ|	ぴ	ぴ|	ぷ	ぷ|	ぺ	ぺ|	ぽ	ぽ|
う|゛	う゛|
"

PIPELINETAB2 = "\
|ゃ	ゃ|	|ゅ	ゅ|	|ょ	ょ|
|ぁ	ぁ|	|ぃ	ぃ|	|ぅ	ぅ|	|ぇ	ぇ|	|ぉ	ぉ|
|ゎ	ゎ|	ー	ー|	っ	っ|
"

KANROM = "\
あ|	a|	い|	i|	う|	u|	え|	e|	お|	o|
か|	ka|	き|	ki|	く|	ku|	け|	ke|	こ|	ko|
さ|	sa|	し|	shi|	す|	su|	せ|	se|	そ|	so|
た|	ta|	ち|	chi|	つ|	tsu|	て|	te|	と|	to|
な|	na|	に|	ni|	ぬ|	nu|	ね|	ne|	の|	no|
は|	ha|	ひ|	hi|	ふ|	fu|	へ|	he|	ほ|	ho|
ま|	ma|	み|	mi|	む|	mu|	め|	me|	も|	mo|
や|	ya|	ゆ|	yu|	よ|	yo|
ら|	ra|	り|	ri|	る|	ru|	れ|	re|	ろ|	ro|
わ|	wa|	ゐ|	i|	ゑ|	e|	を|	o|	ん|	ñ|
が|	ga|	ぎ|	gi|	ぐ|	gu|	げ|	ge|	ご|	go|
ざ|	za|	じ|	ji|	ず|	zu|	ぜ|	ze|	ぞ|	zo|
だ|	da|	ぢ|	ji|	づ|	zu|	で|	de|	ど|	do|
ば|	ba|	び|	bi|	ぶ|	bu|	べ|	be|	ぼ|	bo|
ぱ|	pa|	ぴ|	pi|	ぷ|	pu|	ぺ|	pe|	ぽ|	po|
きゃ|	kya|	きゅ|	kyu|	きょ|	kyo|
しゃ|	sha|	しゅ|	shu|	しょ|	sho|
ちゃ|	cha|	ちゅ|	chu|	ちょ|	cho|
ひゃ|	hya|	ひゅ|	hyu|	ひょ|	hyo|
りゃ|	rya|	りゅ|	ryu|	りょ|	ryo|
ぎゃ|	gya|	ぎゅ|	gyu|	ぎょ|	gyo|
じゃ|	ja|	じゅ|	ju|	じょ|	jo|
ぢゃ|	ja|	ぢゅ|	ju|	ぢょ|	jo|
にゃ|	nya|	にゅ|	nyu|	にょ|	nyo|
びゃ|	bya|	びゅ|	byu|	びょ|	byo|
ぴゃ|	pya|	ぴゅ|	pyu|	ぴょ|	pyo|
みゃ|	mya|	みゅ|	myu|	みょ|	myo|
くぁ|	kwa|	くぃ|	kwi|	くぇ|	kwe|	くぉ|	kwo|
ぐぁ|	gwa|	ぐぃ|	gwi|	ぐぇ|	gwe|	ぐぉ|	gwo|
しぇ|	she|
ちぇ|	che|
じぇ|	je|
つぁ|	tsa|	つぃ|	tsi|	つぇ|	tse|	つぉ|	tso|
てぃ|	ti|	とぅ|	tu|
てゅ|	tyu|
どぅ|	du|
でぃ|	di|	でゅ|	dyu|
ひぇ|	hye|
ふぁ|	fa|	ふぃ|	fi|	ふぇ|	fe|	ふぉ|	fo|
ふゃ|	fya|	ふゅ|	fyu|	ふょ|	fyo|
うぁ|	wa|	うぃ|	wi|	うぇ|	we|	うぉ|	wo|
う゛ぁ|	va|	う゛ぃ|	vi|	う゛ぇ|	ve|	う゛ぉ|	vo|	う゛|	vu|	いぃ|	yi|	いぇ|	ye|
ゆぃ|	yi|	ゆぇ|	ye
きぃ|	kyi|	きぇ|	kye|
にぃ|	nyi|	にぇ|	nye|
りぃ|	ryi|	りぇ|	rye|
ぎぃ|	gyi|	ぎぇ|	gye|
びぃ|	byi|	びぇ|	bye|
ぴぃ|	pyi|	ぴぇ|	pye|
みぃ|	myi|	みぇ|	mye|
しぃ|	shyi|	ちぃ|	chyi|
じぃ|	jyi|	きゎ|	kwa|
ぎゎ|	gwa|	ほぇ|	hwe|
う゛ゅ|	vyu|	くゎ|	kwa|	すぃ|	swi|	ほぃ|	hwi|	ぴぉ|	pyo|	ぷぇ|	pwe|	ぶぉ|	bwo|	すぇ|	swe|
ー|	-|	っ|	x|
’	'	‘	'
"

NASAL = "\
ñ|a	n|’a	ñ|i	n’|i	ñ|u	n’|u	ñ|e	n’|e	ñ|o	n’|o	ñ|y	n’|y
ñ|'a	n|’a	ñ|'i	n|’i	ñ|'u	n|’u	ñ|'e	n|’e	ñ|'o	n|’o	ñ|'y	n|’y

ñ	n
"

KILLPIPE = "\
|		\　	\ 	､	, 	･	·	•	·
"

LANGVOC = "\
xk	kk	xg	gg	xs	ss	xz	zz	xj	jj	xt	tt	xd	dd	
xh	hh	xf	ff	xb	bb	xp	pp	xr	rr	xc	tc	x	’
’'k	kk	’'g	gg	’'s	ss	’'z	zz	’'j	jj	’'t	tt	’'d	dd	
’'c	tc	’'h	hh	’'f	ff	’'b	bb	’'p	pp	’'r	rr
’·k	k·k	’·g	g·g	’·s	s·s	’·z	z·z	’·j	j·j	’·t	t·t	’·d	d·d	
’·c	t·c	’·h	h·h	’·f	f·f	’·b	b·b	’·p	p·p	’·r	r·r	’·<k	k·k
aa	a-	ii	ii	uu	u-	ee	e-	oo	o-	ou	o-	a-	ā	
i-	ī	u-	ū	e-	ē	o-	ō
"
