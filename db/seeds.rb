# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'test@test.com',
    password: "testtest"
)

users_attributes = [
  {
    name: "みゆみゆ",
    email: "a@a",
    local_person: 0,
    image: "miyumiyu.png"
  },
  {
    name: "原田",
    email: "a@b",
    local_person: 1,
    introduction: "こんにちは！北九州育ちの外食好きOLです。",
    image: "harada.png"
  },
  {
    name: "ちみちゃん",
    email: "a@c",
    local_person: 0
  },
  {
    name: "無職",
    email: "a@d",
    local_person: 1,
    introduction: "小倉周辺をぶらぶらして楽しんでます。"
  },
  {
    name: "りゅーたろ",
    email: "a@e",
    local_person: 0
  },
  {
    name: "まる@歯科助手辞める",
    email: "a@f",
    local_person: 0
  },
  {
    name: "♡みい♡",
    email: "a@g",
    local_person: 0,
    introduction: "旅行飯～～",
    image: "timi.png"
  },
    {
    name: "ちくわ",
    email: "a@h",
    local_person: 0
  },
  {
    name: "倉本武夫",
    email: "a@i",
    local_person: 1,
    introduction: "倉本武夫と申します。会社員をしながら趣味の食べ歩きを楽しんでおります。よろしくお願いいたします。",
    image: "takeo.png"
  },
  {
    name: "美優",
    email: "a@j",
    local_person: 0
  },
  {
    name: "大輔",
    email: "a@k",
    local_person: 1
  },
  {
    name: "みさき",
    email: "a@l",
    local_person: 0
  },
  {
    name: "社畜のもちお",
    email: "a@m",
    local_person: 1,
    image: "motio.jpg"
  },
  {
    name: "Yuki",
    email: "a@n",
    local_person: 0
  },
  {
    name: "まさふみ",
    email: "a@o",
    local_person: 1
  }
]

users_attributes.each do |user_attributes|
  image_file = user_attributes[:image]
  user_attributes.delete(:image)
  user = User.create!(user_attributes.merge(password: "aaaaaa"))
  if image_file.present?
    sleep(0.5)
    user.image.attach(io: File.open("#{Rails.root}/db/fixtures/images/#{image_file}"), filename:"sample.jpg")
  end
end

reviews_attributes = [
  {
    user_id: 9,
    shop: "和食の里 つばき",
    address: "福岡県北九州市小倉北区足原１丁目",
    genre: "和食割烹",
    title: "和の真髄です",
    body: "和食割烹 「和食の里 つばき」を訪れました。
           まず、店内は清潔感があり、静謐な空間が広がり、まさに和の趣を感じさせる佇まいです。
           職人の皆様の所作には一切の妥協がなく、一品一品に丁寧な仕事ぶりが見て取れます。
           料理においても、素材の持ち味が最大限に引き出されており、特に旬の魚を使用した刺身と、炊き立ての土鍋ご飯には感銘を受けました。
           純和風の味わいに心満たされ、改めて北九州の食文化の奥深さを感じることができました。
           隠れ家のように奥まった場所に入口があるので、初めての人は入りにくさを感じるかもしれません。",
    star: 1,
    image: "takeo1.jpg"
  },
  {
    user_id: 4,
    shop: "炭火焼肉の家 風",
    address: "福岡県北九州市小倉北区大門１丁目６−１９",
    genre: "焼肉",
    title: "焼肉の気分",
    body: "アーケードでふらっと入った店がよかった。
           店の雰囲気は落ち着いてて、まあ居心地はいい感じ。
           炭火で焼くから肉の香ばしさがちょっとクセになる。
           カルビもまあまあ旨くて、気づいたら結構食ってたかも。
           タレも無難に美味いし、なんだかんだ満足。
           フラッと焼肉行きたい時にはアリだな。",
    star: 4
  },
  {
    user_id: 7,
    shop: "お茶の間 茶花",
    address: "福岡県北九州市小倉北区鍛冶町２丁目３",
    genre: "和菓子とお茶",
    title: "お抹茶タイム～(o^―^o)",
    body: "お城の参道にを歩いてたら人が並んでるお店が…！
           気になって入ってみました。
           和菓子とお茶が楽しめるお店で、もう本当に美味しかった〜
           色々な和菓子があって、どれも素敵な見た目なの。並ぶ価値あり！また行きたいな〜",
    star: 5,
    image: "mii4.png"
  },
  {
    user_id: 7,
    shop: "マルシェ・ブラン",
    address: "福岡県北九州市小倉南区上曽根５丁目１１",
    genre: "パン屋",
    title: "パンタイム～",
    body: "予定の合間に見つけたパン屋さん、あたりだった～(^▽^)/",
    star: 5
  },
  {
    user_id: 9,
    shop: "海の幸 ほたる",
    address: "福岡県北九州市小倉北区京町１丁目６",
    genre: "海鮮系居酒屋",
    title: "北九の海の幸",
    body: "先日、「海の幸 ほたる」を訪れ、新鮮な海鮮料理を存分に楽しむことができました。
          店内は落ち着いた雰囲気で、スタッフの方々の対応も丁寧。特にお造りの盛り合わせは圧巻で、刺身の一切れ一切れに鮮度が感じられました。
          焼き物や煮付けも、魚介の旨味を活かした絶妙な味わい。
          地元の海で採れた魚介を使用しているとのことで、地元愛が伝わる一品一品に心から満足しました。",
    star: 5,
    image: "takeo2.jpg"
  },
  {
    user_id: 2,
    shop: "食彩ダイニング みらい",
    address: "福岡県北九州市門司区柳町１丁目９",
    genre: "イタリアン",
    title: "健康的でした",
    body: "サラダがメインのイタリアンで、ヘルシーなのに満足感がありました。
          友達とシェアしながら、色んなサラダを楽しめるのが良かった。",
    star: 5,
    image: "harada1.jpg"
  },
  {
    user_id: 9,
    shop: "風味亭 うめの",
    address: "福岡県北九州市小倉北区上富野３丁目１７",
    genre: "もつ鍋",
    title: "もつを楽しむ",
    body: "「風味亭 うめの」にて、評判のもつ鍋を味わいました。
          店内は落ち着きがあり、どこか懐かしい和の趣が感じられます。
          鍋のもつは非常に上質で、ぷりぷりとした食感が際立ち、一口ごとに濃厚な旨味が口いっぱいに広がりました。
          スープも絶品で、もつの風味をしっかり引き立てる味わい深い仕上がりとなっており、最後に雑炊にしても格別です。
          良質なもつ鍋を求める方にはぜひ一度足を運んでいただきたい名店です。",
    star: 5,
    image: "takeo3.png"
  },
  {
    user_id: 7,
    shop: "焼き鳥処なぎ",
    address: "福岡県北九州市小倉北区砂津３丁目１−１−１０７０",
    genre: "焼き鳥",
    title: "今日は焼き鳥の日！",
    body: "地元のおじさんから教えてもらったお店、最初は外観がちょっと地味で入るのに勇気がいったけど、行ってみて本当に良かった〜！
          店主が超気さくで、初めてなのにすぐに仲良くなれちゃった♡
          焼き鳥はどれも絶品で、特に名物の鳥皮餃子がめっちゃ美味しかった！
          ここの焼き鳥、ほんとにおすすめだよ〜。
          隠れた名店って感じで、知ってる人だけが得られる幸せだね♪また行きたいな〜！",
    star: 1,
    image: "mii3.png"
  },
  {
    user_id: 2,
    shop: "ビストロ・ナチュール",
    address: "福岡県北九州市若松区高須東４丁目１２",
    genre: "ステーキ",
    title: "ステーキです",
    body: "気になってたお店に行ってきました。
          繁華街の路地にあるおしゃれなステーキ屋さんで、行ってみたら大正解でした。
          ステーキはジューシーで、肉の旨味がしっかり感じられました。
          店内の雰囲気も落ち着いていて、仕事の疲れが一気に癒されました。",
    star: 4
  },
  {
    user_id: 9,
    shop: "美味屋",
    address: "福岡県北九州市小倉南区葛原本町１丁目１３−８",
    genre: "鉄鍋餃子",
    title: "北九州名物、鉄鍋餃子",
    body: "「美味屋」にて、北九州の名物である鉄鍋餃子を堪能しました。
          店内は活気がありながらも落ち着きがあり、ゆったりとした空間で食事を楽しめます。
          鉄鍋でじっくり焼かれた餃子は、外はパリパリ、中はジューシーで、噛むたびに肉汁が広がる絶妙な一品でした。
          皮の焼き加減も程よく、香ばしさと餡の旨味が絶妙なバランスで引き立てられています。
          地元の味を心ゆくまで楽しむことができ、大満足の時間でした。
          北九州らしい鉄鍋餃子を求めるなら、ぜひ一度訪れてほしいお店です。",
    star: 5,
    image: "takeo4.jpg"
  },
  {
    user_id: 7,
    shop: "シーフード・サンクチュアリ",
    address: "福岡県北九州市小倉北区浅野２丁目９",
    genre: "イタリアン",
    title: "おしゃれランチ！",
    body: "超かわいいイタリアンのお店、シーフード・サンクチュアリに行ってきたよ〜！
          ここの料理、見た目がマジで最高！
          色とりどりのシーフードが盛り付けられてて、思わず写真をいっぱい撮っちゃった♡
          シーフードパスタは、海の幸がたっぷり入ってて、味もばっちり。
          インスタに載せたら、友達からも「美味しそう！」ってコメントが止まらなかったよ〜！
          ここはリピ確定だね♪",
    star: 5,
    image: "mii2.jpg"
  },
  {
    user_id: 2,
    shop: "サステイナブル・グリル",
    address: "福岡県北九州市小倉北区京町４丁目２",
    genre: "ハンバーグ",
    title: "ハンバーグ",
    body: "すごくリーズナブルでびっくり。
          ジューシーでボリュームもあって、味も絶品でした。
          お財布にも優しくて、気軽に通えるお店だなと思いました。
          休日にリフレッシュできる場所、見つけたかも。
          また行きたいです！",
    star: 5,
  },
  {
    user_id: 9,
    shop: "夢彩",
    address: "福岡県北九州市小倉北区室町２丁目１０",
    genre: "小料理",
    title: "心安らぐ小料理屋",
    body: "「夢彩」を訪れ、心落ち着く和の料理を堪能しました。
          店内は温かみのある雰囲気で、静かに流れる時間の中で丁寧に作られた料理を味わえます。
          一品一品が繊細で、特に旬の食材を活かした小鉢料理は見た目も美しく、口に含むと素材の持ち味が存分に引き出されていることがわかります。
          店主の心遣いが感じられる優しい味わいと、細部にこだわり抜かれた盛り付けに感銘を受けました。
          和食の奥深さと、日本料理の美しさを再確認できる一軒です。",
    star: 3,
  },
  {
    user_id: 7,
    shop: "ラーメン本舗 ひな",
    address: "福岡県北九州市小倉北区西港町１５−４８",
    genre: "豚骨ラーメン",
    title: "激うまだったにょ",
    body: "SNSでバズってた豚骨ラーメンを食べに行きました(o^―^o)
          北九州来たら、ここ絶対リピするって決めた！ってくらい美味しかったにょ♪",
    star: 4,
    image: "mii1.jpg"
  },
  {
    user_id: 4,
    shop: "麺匠 鶏と豚",
    address: "福岡県北九州市戸畑区初音町１１",
    genre: "ラーメン",
    title: "ちょっと寄り道",
    body: "最近オープンしたラーメン屋に行ってみた。
          スープは鶏と豚のダシが効いてて、わりとコクがある感じ。
          でも思ったよりしつこくなくて、飲みやすい。
          麺もスープと絡みが良くて、まあ悪くない。
          チャーシューも柔らかくていいアクセント。
          こじんまりしてるから入りにくいかもしれん。",
    star: 2,
    image: "musyoku1.png"
  }
]

reviews_attributes.each do |review_attributes|
  image_file = review_attributes[:image]
  review_attributes.delete(:image)
  review = Review.create!(review_attributes)
  if image_file.present?
    sleep(0.5)
    review.image.attach(io: File.open("#{Rails.root}/db/fixtures/images/#{image_file}"), filename:"sample.jpg")
  end
end