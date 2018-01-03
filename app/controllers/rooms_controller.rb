class RoomsController < ApplicationController
  def index
    @room = Search::Room.new
    @options = Plan.pluck(:name, :id)
  end

  def show
  end

  def search
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
