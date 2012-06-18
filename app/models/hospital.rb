class Hospital < ActiveRecord::Base
  belongs_to :service_area
  validates :name, :presence => true
  validates :service_area, :presence => true
end
