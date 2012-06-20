class ServiceArea < ActiveRecord::Base
  validates :name, :presence => true
end
