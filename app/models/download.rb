class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_file
  belongs_to :service_area
  validates_uniqueness_of :content_file_id, :scope => :user_id
end
