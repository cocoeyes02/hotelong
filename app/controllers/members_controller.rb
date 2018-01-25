class MembersController < ApplicationController
  def show
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @member = Member.find(params[:id])
  end

  def new
    if current_member
      redirect_to :rooms
    end
    @member = Member.new()
  end

  def confirm
    if current_member
      redirect_to :rooms
    end
    @member = Member.new(member_params)
  end

  def create
    if current_member
      redirect_to :rooms
    end
    @member = Member.new(member_params)
    if @member.save
      redirect_to :root, info: '新規会員登録が完了しました。'
    else
      render 'new'
    end
  end

  def edit
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @member = Member.find(params[:id])
  end

  def update
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to @member, info: '会員情報を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :root, info: '退会しました。ご利用いただきありがとうございました。'
  end

  def member_params
    params.require(:member).permit(:user_id, :name, :sex, :tel, :address, :birthday, :email, :password)
  end
end
