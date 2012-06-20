class ContentFile < ActiveRecord::Base
  has_many :tags
  has_many :categories, :through => :tags
  belongs_to :service_area

  attr_accessible :title, :description, :word_file, :dreamweaver_file

  validates :title, :presence => true
  validates :description, :presence => true
  validates :title, :presence => true
  
  mount_uploader :word_file, WordContentFileUploader
  mount_uploader :dreamweaver_file, DreamWeaverContentFileUploaderUploader
end
