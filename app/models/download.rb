class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_file
end
