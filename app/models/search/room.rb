class Search::Room < Search::Base
  ATTRIBUTES = %i(
    price
    person
    start_date
    end_date
    plan
    condition
  )
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {})
    if params.is_a?(ActionController::Parameters)
      [:start_date, :end_date].each do |attribute|
        datetime_parts = (1..3).map { |i| params.delete("#{attribute}(#{i}i)") }
        params[attribute] = Time.zone.local(*datetime_parts) if datetime_parts.any?
      end
    end
    super
  end

  def matches
    results = ::Room.all
    if condition == 'and'
      results = results.joins(:class_room).where('class_rooms.price <= ?', price) if price.present?
      results = results.joins(:class_room).where('class_rooms.person = ?', person) if person.present?
      results = results.joins(:plan).where('plans.id = ?', plan) if plan.present?
      results = results.joins('JOIN reservations ON reservations.room_id = rooms.id')
                  .where('(reservations.start_date > ?) AND (reservations.end_date <= ?)', end_date, start_date)
                  .select('reservations.start_date, reservations.end_date') if start_date.present? && end_date.present?
    end
    if condition == 'or'
      results = nil
      results.push(results.joins(:class_room).where('class_rooms.price <= ?', price)).uniq if price.present?
      results.push(results.joins(:class_room).where('class_rooms.person = ?', person)).uniq if person.present?
      results.push(results.joins(:plan).where('plans.id' => plan)). if plan.present?
      results.push(results.joins('JOIN reservations ON reservations.room_id = rooms.id')
                    .where('(reservations.start_date > ?) AND (reservations.end_date <= ?)',
                           end_date, start_date)).uniq if start_date.present? && end_date.present?
    end
    results
  end
end