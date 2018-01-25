class Admin::PlansController < Admin::Base
  def index
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plans = Plan.all
  end

  def new
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plan = Plan.new()
  end

  def create
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to :admin_plans, info: '宿泊予約が完了しました。'
    else
      render 'new'
    end
  end

  def edit
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plan = Plan.find(params[:id])
  end

  def update
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plan = Plan.find(params[:id])
    @plan.assign_attributes(plan_params)
    if @plan.save
      redirect_to :admin_plans, info: 'プラン情報を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to :admin_plans, info: 'プラン情報を削除しました'
  end

  def plan_params
    params.require(:plan).permit(:name, :apply_count, :price)
  end
end
