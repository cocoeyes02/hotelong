room_ids = %w(3 3 3 14 11 14 16 20 16 21)
plan_ids = %w(1 1 1 1 3 1 6 1 6 7)
member_ids = %w(1 1 1 2 2 3 4 4 5 6)
guest_counts = %w(1 1 1 2 2 2 3 3 3 3)
sum_prices = %w(10000 20000 10000 19800 19000 19900 19000 42720 21919 20900)
start_dates = %w(2018-01-01 2018-01-02 2018-01-04 2018-01-01 2018-01-04 2018-01-02 2018-01-02 2018-01-03 2018-01-03 2018-01-03)
end_dates = %w(2018-01-02 2018-01-04 2018-01-05 2018-01-02 2018-01-05 2018-01-03 2018-01-03 2018-01-05 2018-01-04 2018-01-04)
is_extends = %w(false true true false false false false true false false)

0.upto(9) do |idx|
  Reservation.create(
    room_id: room_ids[idx],
    plan_id: plan_ids[idx],
    member_id: member_ids[idx],
    guest_count: guest_counts[idx],
    sum_price: sum_prices[idx],
    start_date: start_dates[idx],
    end_date: end_dates[idx],
    is_extend: is_extends[idx]
  )
end