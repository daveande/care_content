class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_file
  belongs_to :service_area
  validates_uniqueness_of :content_file_id, :scope => :user_id
  validate :user_has_valid_purchase
  validate :user_has_available_download

  def user_has_valid_purchase
    if self.user.current_plan.nil? || self.user.purchases.nil? || self.user.purchases.where(:expired => false).empty?
      errors.add(:user, "does not have any available downloads. Please purchase a download or subscription plan.")
    end
  end

  def user_has_available_download
    return unless errors.blank?
    downloads_per = Plan.find(self.user.current_plan).downloads_per
    current_downloads = self.user.downloads.where("date_part('#{downloads_per}', created_at) = ?", Date.today.send(downloads_per)).count 
    if current_downloads > self.user.valid_purchases.first.plan.max_downloads
      errors.add(:user, "has exceeded purchased downloads. Please purchase a download or upgrade your subscription.")
    end
  end

end
