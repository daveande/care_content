class PurchasesController < ApplicationController
  before_filter :authenticate_user!
  def new
    if params[:plan_id].nil?
      flash[:notice] = "Please select a plan before purchasing" 
      redirect_to plans_url
    else
      @plan = Plan.find(params[:plan_id])
      @purchase = Purchase.new
    end
  end

  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.period_end = Time.now + 1.years

    if @purchase.save
      current_user.current_purchase = @purchase.id
      current_user.save
      SuggestionsMailer.confirmed_purchase_email(@purchase).deliver
      flash[:success] = "Thanks for your purchase. You may start downloading content."
      redirect_to content_files_url
    else
      @plan = Plan.find(params[:purchase][:plan_id])
      render :new
    end
  end

  def index
    @purchases = Purchase.where(:user_id => current_user.id).order("expired")
  end

  def current_purchase
    @user = current_user
    @purchase = Purchase.find(params[:purchase_id])
    @user.current_purchase = @purchase.id
    @user.save
    flash[:success] = "You will now download from the selected plan."
    redirect_to user_purchases_url
  end
end
