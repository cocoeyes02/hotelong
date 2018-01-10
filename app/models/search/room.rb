class Search::Room < Search::Base
  ATTRIBUTES = %i(
    price
    person
    start_date
    end_date
    plans
    condition
  )
  attr_accessor(*ATTRIBUTES)
  # TODO: 検索バリデーションの追加

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
      # ノープランの時はperson_priceから計算する
      results = results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id').where('class_rooms.person_price <= ?', price.to_i) if price.present? && plan.to_i == 1
      # プラン選択時にはプラン料金から計算する
      results = results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id',
                              'JOIN plan_rooms ON plan_rooms.room_id = rooms.id',
                              'JOIN plans ON plans.id = plan_rooms.plan_id').where('plans.id = ? AND plans.price / apply_count <= ?', plan.to_i, price.to_i) if price.present? && plan.to_i != 1
      results = results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id').where('class_rooms.expect_count = ? OR (class_rooms.expect_count = ? AND class_rooms.can_add_bed = ?)', person.to_i, person.to_i+ 1, true) if person.present?
      results = results.joins('JOIN plan_rooms ON plan_rooms.room_id = rooms.id',
                              'JOIN plans ON plans.id = plan_rooms.plan_id').where('plans.id = ?', plan.to_i)
      results = results.where(room_number: Reservation.emptyRoomNumberListByDate(start_date.strftime('%Y-%m-%d'), end_date.strftime('%Y-%m-%d'))) if start_date.present? && end_date.present?
    end
    if condition == 'or'
      result_ids = []
      # ノープランの時はperson_priceから計算する
      result_ids.push(results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id').where('class_rooms.person_price <= ?', price.to_i).pluck(:id)) if price.present? && plan.to_i == 1
      # プラン選択時にはプラン料金から計算する
      result_ids.push(results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id',
                              'JOIN plan_rooms ON plan_rooms.room_id = rooms.id',
                              'JOIN plans ON plans.id = plan_rooms.plan_id').where('plans.id = ? AND plans.price / apply_count <= ?', plan.to_i, price.to_i).pluck(:id)) if price.present? && plan.to_i != 1
      result_ids.push(results.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id').where('class_rooms.expect_count = ? OR (class_rooms.expect_count = ? AND class_rooms.can_add_bed = ?)', person.to_i, person.to_i+ 1, true).pluck(:id)) if person.present?
      # ノープランはどの部屋にもあるので検索条件から外す
      result_ids.push(results.joins('JOIN plan_rooms ON plan_rooms.room_id = rooms.id',
                              'JOIN plans ON plans.id = plan_rooms.plan_id').where('plans.id = ?', plan.to_i).pluck(:id)) if plan.to_i != 1
      result_ids.push(results.where(room_number: Reservation.emptyRoomNumberListByDate(start_date.strftime('%Y-%m-%d'), end_date.strftime('%Y-%m-%d'))).pluck(:id)) if start_date.present? && end_date.present?
      result_ids.flatten!
      result_ids.uniq!
      results = results.where(id: result_ids)
    end
    results
  end
end