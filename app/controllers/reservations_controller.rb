class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order('id')
    @rooms = Room.order('id')
  end

  def show
  end

  def new
  end

  def confirm
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
