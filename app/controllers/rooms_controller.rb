class RoomsController < ApplicationController
  def index
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @room = Search::Room.new
    @rooms = Room.all
    @options = Plan.pluck(:name, :id)
  end

  def show
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @room = Room.joins('JOIN class_rooms ON class_rooms.id = rooms.class_room_id').select(
      'rooms.*, class_rooms.person_price, class_rooms.style_name, class_rooms.expect_count, class_rooms.can_add_bed'
    ).find(params[:id])
    @plans = PlanRoom.joins('JOIN plans ON plans.id = plan_rooms.plan_id').select('plans.*').where('plan_rooms.room_id = ?', params[:id])
    @options = PlanRoom.joins('JOIN plans ON plans.id = plan_rooms.plan_id').select('plans.*').where('plan_rooms.room_id = ?', params[:id]).pluck('plans.name, plans.id')
    session[:options] = @options
    session[:room] = @room.id
  end

  def search
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @options = Plan.pluck(:name, :id)
    @room = Search::Room.new(search_params)
    @rooms = @room
                  .matches
                  .order('rooms.id')
    render 'index'
  end

  private
  # 検索フォームから受け取ったパラメータ
  def search_params
    params
      .require(:search_room)
      .permit(Search::Room::ATTRIBUTES)
  end
end
