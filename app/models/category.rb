class Category < ActiveRecord::Base
  has_many :tags
  has_many :content_files, :through => :tags
end
