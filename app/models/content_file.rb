class ContentFile < ActiveRecord::Base
  has_many :tags
  has_many :categories, :through => :tags
  has_many :service_areas, :through => :downloads
  has_many :downloads

  attr_accessible :service_area_ids, :preview_text, :category_ids, :title, :description, :word_file, :remove_word_file, :dreamweaver_file, :remove_dreamweaver_file

  validates_presence_of :title, :description

  mount_uploader :word_file, WordContentFileUploader
  mount_uploader :dreamweaver_file, DreamWeaverContentFileUploaderUploader
end
