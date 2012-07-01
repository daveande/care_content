ActiveAdmin.register AdminUser do
  index do 
    column :email
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do 
      f.input :email, :hint => "Enter email of Admin User. The user will receive an email with a link to change/enter a password."
      f.input :password, :hint => "Enter a new password and password confirmation. You'll have to inform user of the new password."
      f.input :password_confirmation
    end
    f.buttons
  end
  
  show do |user|
    attributes_table do
      row :email
      row :sign_in_count
      row :last_sign_in_at
      row :created_at
      row :updated_at
    end
  end
end
