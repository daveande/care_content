ActiveAdmin.register ContentFile do
  index do
    column :title
    column :description
    column :service_area
    column :categories
    
  end

  filter :service_area
  filter :title
  filter :description
  
end
