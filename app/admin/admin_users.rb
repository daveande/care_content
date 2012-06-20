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
    end
    f.buttons
  end
  
end
