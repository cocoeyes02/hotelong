user_ids = %w(itiro jiro saburo shiro goro rokuro sitiro hatiro kuro toro)
names = %w(鈴木一郎 拉麺二郎 北島三郎 天草四郎 茂野五郎 菅六郎 多田野七郎 根田切八郎 北風小僧野勘九郎 重荷十郎)
addresses = %w(徳島県三好市井川町旭町4-15-6 鳥取県東伯郡琴浦町松谷1-12-17 鳥取県鳥取市国府町谷1-7 広島県東広島市黒瀬町菅田2-16-19 神奈川県海老名市浜田町4-12-14 山形県酒田市荒町4-8-10 徳島県徳島市南矢三町3-20-4 茨城県水戸市浜田町1-4コンフォート浜田町210 青森県三戸郡五戸町上川原4-15ゴールデン上川原101 岡山県岡山市北区苔山3-9メゾン苔山104)
tels = %w(0970275098 0978915116 0770823391 0537358308 0736336391 0445090283 0524904446 0844058687 0586687425 09012345678)
birthdays = %w(1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01 1990-10-01)
emails = %w(itiro@hoge.jp jiro@hoge.jp saburo@hoge.jp shiro@hoge.jp goro@hoge.jp rokuro@hoge.jp sitiro@hoge.jp hatiro@hoge.jp kuro@hoge.jp toro@hoge.jp)
admin_authoritys = [true, false]

0.upto(9) do |idx|
  Member.create(
    user_id: user_ids[idx],
    password: "password",
    name: names[idx],
    sex: (idx % 2) + 1,
    address: addresses[idx],
    tel: tels[idx],
    birthday: birthdays[idx],
    email: emails[idx],
    admin_authority: admin_authoritys[idx % 2]
  )
end