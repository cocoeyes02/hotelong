class MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
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
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to @member, notice: '会員情報を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :root, notice: '退会しました。ご利用いただきありがとうございました。'
  end

  def member_params
    params.require(:member).permit(:user_id, :name, :sex, :tel, :address, :birthday, :email, :password)
  end
end
