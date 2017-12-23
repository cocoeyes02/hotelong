room_numbers = %w(101 102 103 104 105 201 202 203 204 205 301 302 303 304 305 401 402 403 404 405 501 502 503 504 505)

0.upto(24) do |idx|
  Room.create(
    class_room_id: (idx / 5).floor + 1,
    room_number: room_numbers[idx]
  )
end