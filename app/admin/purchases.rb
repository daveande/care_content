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
  
end
