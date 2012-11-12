class Category < ActiveRecord::Base
  has_many :tags
  has_many :content_files, :through => :tags

  validates_presence_of :name
end
