class Tag < ActiveRecord::Base
  belongs_to :category
  belongs_to :content_file
end
