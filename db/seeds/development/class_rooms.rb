person_prices = %w(10000 9900 9500 8900 8500)
style_names = %w(シングル ダブル ツイン ダブル（エクストラ） ツイン（エクストラ）)
expect_counts = %w(1 2 2 2 2)
can_add_beds = %w(false false false true true)
discount_rates = %w(1.00 1.00 1.00 0.80 0.80)
surchage_rates = %w(1.20 1.20 1.20 1.20 1.20)

0.upto(4) do |idx|
  ClassRoom.create(
    person_price: person_prices[idx],
    style_name: style_names[idx],
    expect_count: expect_counts[idx],
    can_add_bed: can_add_beds[idx],
    discount_rate: discount_rates[idx],
    surcharge_rate: surchage_rates[idx]
  )
end