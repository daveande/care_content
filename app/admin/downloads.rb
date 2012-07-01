ActiveAdmin.register Download do
  actions :index, :destroy
  index do 
    column :content_file
    column :user
    column "Hospital" do |download|
      download.user.hospital.name unless download.user.hospital.nil?
    end
    default_actions
  end 
end
