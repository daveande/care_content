ActiveAdmin.register Hospital do
  index do
    column :id
    column :name
    column :address
    column :city
    column :state
    column :zip
    column :service_area
    default_actions
  end
  
end
