ActiveAdmin.register Purchase do
  index do 
    column :user
    column :plan
    column :agreed_to_terms
    column :created_at
    column :period_end
    column :expired
    default_actions
  end

  filter :user, :collection => User.all.map{ |user| [user.email, user.id] }
  filter :plan
  filter :period_end
  
  form do |f|
    f.inputs "Purchases" do
      f.input :user, :collection => User.all.map{ |user| [user.email, user.id] }
      f.input :plan
      f.input :agreed_to_terms
      f.input :period_end
      f.input :expired
      f.buttons
    end
  end  

  controller do
    def create
      @purchase = Purchase.new(params[:purchase])
      @user = User.find(params[:purchase][:user_id])

      if @purchase.save
        @user.current_purchase = @purchase.id
        @user.save
        flash[:notice] = 'Purchase was successfully created.'
        redirect_to admin_purchase_url(@purchase)
      else
        render :new
      end
    end

  end

end
