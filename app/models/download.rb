class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_file
  validates_uniqueness_of :content_file_id, :scope => :user_id
end
