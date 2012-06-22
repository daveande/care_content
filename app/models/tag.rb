class Tag < ActiveRecord::Base
  belongs_to :category
  belongs_to :content_file
  attr_accessible :category_id, :content_file_id
end
