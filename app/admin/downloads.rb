ActiveAdmin.register Download do
  actions :index, :destroy
  index do 
    column :content_file
    column :user
    column :service_area
    column :purchase
    column :created_at
    default_actions
  end 
  
  form do |f|
    f.inputs "Downloads" do
      f.input :content_file
      f.input :user
      f.input :service_area
      f.input :purchase
      f.buttons
    end
  end  
end
