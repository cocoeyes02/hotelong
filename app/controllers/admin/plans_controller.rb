class Admin::PlansController < Admin::Base
  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new()
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to :admin_plans, info: '宿泊予約が完了しました。'
    else
      render 'new'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.assign_attributes(plan_params)
    if @plan.save
      redirect_to :admin_plans, info: 'プラン情報を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to :admin_plans, info: 'プラン情報を削除しました'
  end

  def plan_params
    params.require(:plan).permit(:name, :apply_count, :price)
  end
end
