class SessionsController < ApplicationController
  def create
    member = Member.authenticate(params[:user_id], params[:password])
    if member
      session[:member_id] = member.id
      redirect_to :rooms
    else
      flash.alert = 'ユーザIDとパスワードが一致しません'
      redirect_to :root
    end
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end
