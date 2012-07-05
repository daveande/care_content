ActiveAdmin.register Download do
  actions :index, :destroy
  index do 
    column :content_file
    column :user
    column :service_area
    default_actions
  end 
  
  form do |f|
    f.inputs "Downloads" do
      f.input :content_file
      f.input :user
      f.input :service_area
      f.buttons
    end
  end  
end
