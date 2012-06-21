ActiveAdmin.register User do
  actions :index, :show, :destroy
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
  
  form do |f|
    f.inputs do
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :password, :hint => "Enter a new password and password confirmation. You'll have to inform user of the new password."
        f.input :password_confirmation
        f.input :hospital
    end
      f.buttons
  end

  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :hospital
      row :sign_in_count
      row :last_sign_in_at
      row :created_at
      row :updated_at
    end
  end
end
