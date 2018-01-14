class MembersController < ApplicationController
  def show
  end

  def new
    @member = Member.new()
  end

  def confirm
    @member = Member.new(member_params)
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to :root, notice: '新規会員登録が完了しました。'
    else
      redirect_to :root, notice: '新規会員登録に失敗しました。運営者までご連絡ください。'
    end
  end

  def edit
  end

  def update
  end

  def destory
  end

  def member_params
    params.require(:member).permit(:user_id, :name, :sex, :tel, :address, :birthday, :email, :password)
  end
end
