room_ids = %w(1 2 6 7 11 12 16 17 21 22)
plan_ids = %w(1 1 2 4 3 3 5 6 5 6)

0.upto(9) do |idx|
  PlanRoom.create(
    room_id: room_ids[idx],
    plan_id: plan_ids[idx]
  )
end