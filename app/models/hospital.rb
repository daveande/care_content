class Hospital < ActiveRecord::Base
  belongs_to :service_area
  validates_presence_of :name, :service_area
end
