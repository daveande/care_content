class ContentFile < ActiveRecord::Base
  has_many :tags
  has_many :categories, :through => :tags
  belongs_to :service_area
end
