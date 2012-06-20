class Category < ActiveRecord::Base
  has_many :tags
  has_many :content_files, :through => :tags

  validates :name, :presence => true

end
