class Admin::MembersController < Admin::Base
  def index
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @members = Member.all
  end

  def show
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @member = Member.find(params[:id])
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
      redirect_to :admin_members, info: '会員情報を更新しました。'
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
    redirect_to :admin_members, info: '会員情報を削除しました'
  end

  def member_params
    params.require(:member).permit(:user_id, :name, :sex, :tel, :address, :birthday, :email, :password, :admin_authority)
  end
end
