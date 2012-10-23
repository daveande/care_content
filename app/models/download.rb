class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_file
  belongs_to :service_area
  belongs_to :purchase
  validates_uniqueness_of :content_file_id, :scope => :user_id
  validate :user_has_valid_purchase
  validate :user_has_available_download

  def user_has_valid_purchase
    if self.user.current_purchase.nil? || self.user.purchases.nil? || self.user.purchases.where(:expired => false).empty?
      errors.add(:user, "does not have any available downloads. Please purchase a download or subscription plan.")
    end
  end

  def user_has_available_download
    return unless errors.blank?
    purchase = Purchase.find(self.user.current_purchase)
    plan = purchase.plan
    downloads_per = plan.downloads_per
    
    min, max = purchase.current_expire
    
    current_downloads = self.user.downloads.where('created_at BETWEEN ? and ? AND purchase_id = ?', min, max, purchase.id)
    
    if current_downloads.count >= plan.max_downloads
      errors.add(:user, "has exceeded purchased downloads for this plan. Please change your selected plan, purchase additional downloads, or upgrade your subscription.")
    end
  end

end



