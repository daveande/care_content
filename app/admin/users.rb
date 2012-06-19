ActiveAdmin.register User do
  index do 
    column :first_name
    column :last_name
    column :email
    column :hospital
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :updated_at
    default_actions
  end
  
    filter :hospital
    filter :first_name
    filter :last_name
    filter :email
end
