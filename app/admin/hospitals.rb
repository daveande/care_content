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

  filter :service_area
  filter :name
  filter :address
  filter :city
  filter :state
  filter :zip
  
end
